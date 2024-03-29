# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/transformers/cv3_to_ios'
require 'aca_entities/medicaid/ios/operations/generate_ios'
require 'aca_entities/medicaid/ios/contracts/sspdc_request_contract'
require 'aca_entities/medicaid/ios/contracts/ssp_application__c_contract'
require 'aca_entities/medicaid/ios/contracts/ssp_member__c_contract'

RSpec.describe AcaEntities::Medicaid::Ios::Transformers::Cv3ToIos do

  describe 'When a valid cv3 family payload is passed' do
    # should use more recent example payload (and ultimately replace with prepared data version of family)?
    let(:family) do
      json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
      #   json = File.read(Pathname.pwd.join("/Users/michaelkaramanov/Desktop/development/payloads/simple_c.json"))
      prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
      JSON.generate(prepped_data)
    end

    before do
      described_class.call(family) { |record| @transform_result = record }
    end

    it 'should transform the payload according to instructions' do
      expect(@transform_result).to have_key(:SspdcRequest)
      expect(@transform_result[:SspdcRequest]).to have_key(:SubmitType)
      expect(@transform_result[:SspdcRequest]).to have_key(:ApplicationReceivedDateTime)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Application__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Member__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Asset__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Benefits__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_HealthInsuranceFacilityType__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Relationship__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_ApplicationIndividual__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_InsurancePolicy__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_InsuranceCoveredIndiv__c)
      expect(@transform_result[:SspdcRequest]).to have_key(:contact)
    end

    it 'should produce a valid SSPDCRequest object' do
      result = @transform_result[:SspdcRequest]
      expect(AcaEntities::Medicaid::Ios::Contracts::SspdcRequestContract.new.call(result).errors).to be_empty
      # we can decide later if we enforce the contracts on this main object or we enforce it on the separate spec;
      # my guess is the second, but for now I'll leave it here because is handy to develop
      # expect(AcaEntities::Medicaid::Ios::Contracts::SspApplicationCContract.new.call(result[:SSP_Application__c]).errors).to be_empty
      # expect(AcaEntities::Medicaid::Ios::Contracts::SspMemberCContract.new.call(result[:SSP_Member__c]).errors).to be_empty
    end

    context 'default values' do
      context 'SubmitType' do
        it 'should have the correct default value' do
          value = @transform_result[:SspdcRequest][:SubmitType]
          expect(value).to eq 'Intake'
        end
      end
    end
  end
end