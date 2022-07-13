# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/ios/transformers/application'
require 'aca_entities/medicaid/ios/operations/generate_ios'

RSpec.describe AcaEntities::Medicaid::Ios::Transformers::Application do

  describe 'When a valid cv3 application payload is passed' do
    # should use more recent example payload?
    let(:family) do
      json = File.read(Pathname.pwd.join("spec/support/atp/sample_payloads/uber_payload.json"))
      prepped_data = AcaEntities::Medicaid::Ios::Operations::GenerateIos.new.send(:prep_data, json).value!
      prepped_data[:family]
    end

    let(:application) do
      JSON.generate(family[:magi_medicaid_applications])
    end

    before do
      described_class.call(application) { |record| @transform_result = record }
    end

    it 'should transform the payload according to instructions' do
      expect(@transform_result).to have_key(:ApplicationEsignFirstName__c)
      expect(@transform_result).to have_key(:ApplicationEsignMiddleInitial__c)
      expect(@transform_result).to have_key(:ApplicationEsignLastName__c)
    end
  end
end