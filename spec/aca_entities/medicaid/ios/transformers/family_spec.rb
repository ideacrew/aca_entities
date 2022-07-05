# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/functions/ssp_member__c_builder'
require 'aca_entities/medicaid/ios/transformers/family'

RSpec.describe AcaEntities::Medicaid::Ios::Transformers::Family do

  describe 'When a valid cv3 family payload is passed' do
    # should use more recent example payload (and ultimately replace with prepared data version of family)?
    let(:family) do
      File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
    end
    before do
      allow(AcaEntities::Medicaid::Ios::Transformers::Application).to receive(:transform).and_return(double)
      allow(AcaEntities::Medicaid::Ios::Functions::SspMemberCBuilder).to receive(:new).and_return(double)
      allow(AcaEntities::Medicaid::Ios::Functions::SspAssetCBuilder).to receive(:new).and_return(double)
      allow(AcaEntities::Medicaid::Ios::Functions::SspBenefitsCBuilder).to receive(:new).and_return(double)
      described_class.call(family) { |record| @transform_result = record }
    end

    it 'should transform the payload according to instructions' do
      expect(@transform_result).to have_key(:SspdcRequest)
      expect(@transform_result[:SspdcRequest]).to have_key(:SSP_Application__c)
    end
  end
end