# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Brokers::BrokerRole do

  let(:broker_agency_reference) do
    { hbx_id: "1233444", market_kind: 'both', name: 'broker agency', dba: nil, display_name: nil, fein: '089441964', corporate_npn: nil }
  end

  let!(:input_params) do
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

  describe 'with valid arguments' do

    it 'should initialize' do
      expect(described_class.new(input_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(input_params) }.not_to raise_error
    end
  end

  describe 'with invalid arguments' do
    it 'should raise error' do
      expect { described_class.new(input_params.reject { |k, _v| k == :aasm_state }) }.to raise_error(Dry::Struct::Error, /:aasm_state is missing/)
    end
  end
end
