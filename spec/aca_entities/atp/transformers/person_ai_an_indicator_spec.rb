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

RSpec.describe AcaEntities::Atp, "given an inbound XML with person level PersonAmericanIndianOrAlaskaNativeIndicator data" do

  context "when PersonAmericanIndianOrAlaskaNativeIndicator is false for a person" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//hix-core:PersonAmericanIndianOrAlaskaNativeIndicator', 'hix-core' => "http://hix.cms.gov/0.1/hix-core")[1].remove
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    before do
      @transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      @applicants = @transformed[:family][:magi_medicaid_applications].first[:applicants]
      @family_members = @transformed[:family][:family_members]
    end

    it "should set indian_tribe_member as false on person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:indian_tribe_member]).to eq false
      expect(member[:person][:person_demographics][:indian_tribe_member]).to eq false
    end

    it "should set tribal_name to nil for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:tribal_name]).to eq nil
      expect(member[:person][:person_demographics][:tribal_name]).to eq nil
    end

    it "should set tribal_state to nil for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000190"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Rob/)
      end
      expect(applicant[:tribal_state]).to eq nil
      expect(member[:person][:person_demographics][:tribal_state]).to eq nil
    end
  end

  context "when PersonAmericanIndianOrAlaskaNativeIndicator is true for a person" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//hix-core:PersonAmericanIndianOrAlaskaNativeIndicator', 'hix-core' => "http://hix.cms.gov/0.1/hix-core")[0].remove
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    before do
      @transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      @applicants = @transformed[:family][:magi_medicaid_applications].first[:applicants]
      @family_members = @transformed[:family][:family_members]
    end

    it "should set indian_tribe_member as true on person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:indian_tribe_member]).to eq true
      expect(member[:person][:person_demographics][:indian_tribe_member]).to eq true
    end

    it "should set tribal_name for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:tribal_name]).to eq "Eastern Band of Cherokee Indians of North Carolina"
      expect(member[:person][:person_demographics][:tribal_name]).to eq "Eastern Band of Cherokee Indians of North Carolina"
    end

    it "should set tribe_codes for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:tribe_codes]).to eq ["OT"]
      expect(member[:person][:person_demographics][:tribe_codes]).to eq ["OT"]
    end

    it "should set tribal_state for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:tribal_state]).to eq "ME"
      expect(member[:person][:person_demographics][:tribal_state]).to eq "ME"
    end
  end

  context "when PersonAmericanIndianOrAlaskaNativeIndicator element does not exist for a person" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//hix-core:PersonAmericanIndianOrAlaskaNativeIndicator', 'hix-core' => "http://hix.cms.gov/0.1/hix-core").each(&:remove)
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    before do
      @transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      @applicants = @transformed[:family][:magi_medicaid_applications].first[:applicants]
      @family_members = @transformed[:family][:family_members]
    end

    it "should set indian_tribe_member as nil on person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:indian_tribe_member]).to eq nil
      expect(member[:person][:person_demographics][:indian_tribe_member]).to eq nil
    end

    it "should set tribal_name to nil for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:tribal_name]).to eq nil
      expect(member[:person][:person_demographics][:tribal_name]).to eq nil
    end

    it "should set tribal_state to nil for person and applicant" do
      applicant = @applicants.detect do |app|
        app[:person_hbx_id] == "pe2000191"
      end
      member = @family_members.detect do |fm|
        fm[:person][:person_name][:full_name].match(/Nancy/)
      end
      expect(applicant[:tribal_state]).to eq nil
      expect(member[:person][:person_demographics][:tribal_state]).to eq nil
    end
  end

  context "Tribe codes" do
    let(:payload) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample_incarceration_payload.xml"))
    end

    let(:tribe_name) { "Eastern Band of Cherokee Indians of North Carolina" }

    let(:document) do
      document = Nokogiri::XML(payload)
      path = document.xpath('//hix-core:PersonTribeName', 'hix-core' => "http://hix.cms.gov/0.1/hix-core")[0]
      path.content = tribe_name
      document
    end

    let(:account_transfer_request) do
      ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
    end

    before do
      @transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))
      @applicants = @transformed[:family][:magi_medicaid_applications].first[:applicants]
      @family_members = @transformed[:family][:family_members]
    end

    context "when Tribe is Penobscot" do
      let(:tribe_name) { "Penobscot" }

      it "should return valid tribe_codes for applicant and member" do
        applicant = @applicants.detect do |app|
          app[:person_hbx_id] == "pe2000191"
        end
        member = @family_members.detect do |fm|
          fm[:person][:person_name][:full_name].match(/Nancy/)
        end
        expect(applicant[:tribe_codes]).to eq ["PE"]
        expect(member[:person][:person_demographics][:tribe_codes]).to eq ["PE"]
      end
    end

    context "when Tribe is Houlton Maliseets" do
      let(:tribe_name) { "Houlton Maliseets" }

      it "should return valid tribe_codes for applicant and member" do
        applicant = @applicants.detect do |app|
          app[:person_hbx_id] == "pe2000191"
        end
        member = @family_members.detect do |fm|
          fm[:person][:person_name][:full_name].match(/Nancy/)
        end
        expect(applicant[:tribe_codes]).to eq ["HM"]
        expect(member[:person][:person_demographics][:tribe_codes]).to eq ["HM"]
      end
    end

    context "when Tribe is Aroostook Micmac" do
      let(:tribe_name) { "Aroostook Micmac" }

      it "should return valid tribe_codes for applicant and member" do
        applicant = @applicants.detect do |app|
          app[:person_hbx_id] == "pe2000191"
        end
        member = @family_members.detect do |fm|
          fm[:person][:person_name][:full_name].match(/Nancy/)
        end
        expect(applicant[:tribe_codes]).to eq ["AM"]
        expect(member[:person][:person_demographics][:tribe_codes]).to eq ["AM"]
      end
    end

    context "when Tribe is Dana Point Passamaquoddy" do
      let(:tribe_name) { "Dana Point Passamaquoddy" }

      it "should return valid tribe_codes for applicant and member" do
        applicant = @applicants.detect do |app|
          app[:person_hbx_id] == "pe2000191"
        end
        member = @family_members.detect do |fm|
          fm[:person][:person_name][:full_name].match(/Nancy/)
        end
        expect(applicant[:tribe_codes]).to eq ["PD"]
        expect(member[:person][:person_demographics][:tribe_codes]).to eq ["PD"]
      end
    end

    context "when Tribe is Pleasant Point Passamaquoddy" do
      let(:tribe_name) { "Pleasant Point Passamaquoddy" }

      it "should return valid tribe_codes for applicant and member" do
        applicant = @applicants.detect do |app|
          app[:person_hbx_id] == "pe2000191"
        end
        member = @family_members.detect do |fm|
          fm[:person][:person_name][:full_name].match(/Nancy/)
        end
        expect(applicant[:tribe_codes]).to eq ["PD"]
        expect(member[:person][:person_demographics][:tribe_codes]).to eq ["PD"]
      end
    end
  end
end
