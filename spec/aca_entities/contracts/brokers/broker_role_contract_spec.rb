# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Contracts::Brokers::BrokerRoleContract do

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let!(:required_params) do
    {
      aasm_state: "decertified",
      npn: "2355863",
      broker_agency_reference: broker_agency_reference,
      provider_kind: "broker",
      reason: "Broker has obtained carrier appointments and has completed training.",
      market_kind: "both",
      languages_spoken: ["en"],
      working_hours: false,
      accept_new_clients: nil,
      license: nil,
      training: nil,
      carrier_appointments:
          {
            aetna_health_inc: nil,
            aetna_life_insurance_company: nil,
            carefirst_bluechoice_inc: nil,
            group_hospitalization_and_medical_services_inc: nil,
            kaiser_foundation: nil, optimum_choice: nil,
            united_health_care_insurance: nil,
            united_health_care_mid_atlantic: nil
          }
    }
  end

  context 'success case' do
    before do
      @result = subject.call(required_params)
    end

    it 'should return success' do
      expect(@result.success?).to be_truthy
    end

    it 'should not have any errors' do
      expect(@result.errors.empty?).to be_truthy
    end
  end

  context 'failure case' do
    context 'missing required param' do
      before do
        @result = subject.call(required_params.reject { |k, _v| k == :npn })
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('is missing')
      end
    end

    context 'with bad input data type' do
      before do
        @result = subject.call(required_params.merge(npn: nil))
      end

      it 'should return failure' do
        expect(@result.failure?).to be_truthy
      end

      it 'should have any errors' do
        expect(@result.errors.empty?).to be_falsy
      end

      it 'should return error message' do
        expect(@result.errors.messages.first.text).to eq('must be filled')
      end

      it 'should return error message' do
        result = subject.call(required_params.merge(provider_kind: "test"))
        expect(result.errors.messages.first.text).to eq('must be one of: broker, assister')
      end
    end
  end
end
