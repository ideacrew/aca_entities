# frozen_string_literal: true

require "spec_helper"
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/family'
require 'aca_entities/medicaid/atp'
require 'aca_entities/medicaid/contracts/account_transfer_request_contract'
require 'aca_entities/atp/transformers/aces/family'
require 'aca_entities/atp/operations/aces/generate_xml'
require 'aca_entities/serializers/xml/medicaid/atp/account_transfer_request'
require "support/atp/inbound_build_application"
require "aca_entities/atp/transformers/cv/phone"
require "aca_entities/atp/transformers/cv/other_questions"
require "aca_entities/atp/transformers/cv/deduction"
require "aca_entities/atp/transformers/cv/income"
require "aca_entities/atp/transformers/cv/contact_info"
require "aca_entities/atp/functions/lawful_presence_determination_builder"
require "aca_entities/atp/functions/address_builder"
require "aca_entities/functions/age_on"
require "aca_entities/atp/functions/relationship_builder"

RSpec.describe AcaEntities::Atp, "given an inbound XML with multiple applicant level incarceration data" do
  context "when applicant exists for a person" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      Nokogiri::XML(payload)
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    it "should set incarceration data on primary applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      applicants = transformed[:family][:magi_medicaid_applications].first[:applicants]
      family_members = transformed[:family][:family_members]
      applicant = applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:is_incarcerated]).to eq false
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq false
    end

    it "should set incarceration data on another applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      applicants = transformed[:family][:magi_medicaid_applications].first[:applicants]
      family_members = transformed[:family][:family_members]
      applicant = applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:is_incarcerated]).to eq true
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq true
    end
  end

  context "when incarceration indicator does not exists for any applicant" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//hix-ee:InsuranceApplicantIncarceration', 'hix-ee' => "http://hix.cms.gov/0.1/hix-ee").each(&:remove)
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    it "should not set incarceration data on primary applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      applicants = transformed[:family][:magi_medicaid_applications].first[:applicants]
      family_members = transformed[:family][:family_members]
      applicant = applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:is_incarcerated]).to eq nil
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq nil
    end

    it "should set not incarceration data on another applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      applicants = transformed[:family][:magi_medicaid_applications].first[:applicants]
      family_members = transformed[:family][:family_members]
      applicant = applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:is_incarcerated]).to eq nil
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq nil
    end
  end

  context "when applicant exists for one person but not the other" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//hix-ee:InsuranceApplicantIncarceration', 'hix-ee' => "http://hix.cms.gov/0.1/hix-ee")[1].remove
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    it "should not set incarceration data on primary applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      applicants = transformed[:family][:magi_medicaid_applications].first[:applicants]
      family_members = transformed[:family][:family_members]
      applicant = applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:is_incarcerated]).to eq false
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq false
    end

    it "should set not incarceration data on another applicant" do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      family_members = transformed[:family][:family_members]
      member = family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(member[:person][:person_demographics][:is_incarcerated]).to eq nil
    end
  end
end