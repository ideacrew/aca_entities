# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp'
require 'aca_entities/serializers/xml/medicaid/atp'
require 'aca_entities/atp/transformers/cv/family'

RSpec.describe AcaEntities::Atp::Transformers::Cv::Family do
  let(:payload) { File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/sample.xml")) }

  let(:document) do
    Nokogiri::XML(payload)
  end

  let(:account_transfer_request) do
    ::AcaEntities::Serializers::Xml::Medicaid::Atp::AccountTransferRequest.parse(document.root.canonicalize, :single => true)
  end

  describe 'When fixed address indicator passed as true' do

    it 'should set homeless indicator false' do  
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))

      transformed.dig(:family, :family_members).each do |family_member|
        expect(family_member.dig(:person, :is_homeless)).to be_falsey
      end
    end
  end

  describe 'When fixed address indicator not passed in xml' do
    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//ns5:InsuranceApplicantFixedAddressIndicator', 'ns5' => 'http://hix.cms.gov/0.1/hix-ee').each do |node|
        node.remove
      end
      document
    end

    it 'should set homeless indicator based on addresses' do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))

      transformed.dig(:family, :family_members).each do |family_member|
        expect(family_member.dig(:person, :is_homeless)).to be_falsey
      end
    end
  end

  describe 'When fixed address indicator passed as false' do
    let(:document) do
      document = Nokogiri::XML(payload)
      document.xpath('//ns5:InsuranceApplicantFixedAddressIndicator', 'ns5' => 'http://hix.cms.gov/0.1/hix-ee').each do |node|
        node.content = 'false'
      end
      document
    end
    
    let(:expected_homeless_indicators) { [true, true, false] }

    it 'should set homeless indicator true' do
      transformed = ::AcaEntities::Atp::Transformers::Cv::Family.transform(account_transfer_request.to_hash(identifier: true))

      transformed.dig(:family, :family_members).each_with_index do |family_member, index|
        expect(family_member.dig(:person, :is_homeless)).to eq(expected_homeless_indicators[index])
      end
    end
  end
end
