# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/location_street'
require 'aca_entities/medicaid/atp/structured_address'
require 'aca_entities/medicaid/atp/contact_mailing_address'

RSpec.describe ::AcaEntities::Medicaid::Atp::ContactMailingAddress,  dbclean: :around_each do

  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      {
        address:
          {
            location_street: { street_full_text: "123 Easy St" },
            address_secondary_unit_text: "address",
            location_city_name: "Wheaton",
            location_county_name: "Montgomery",
            location_county_code: "code",
            location_state_us_postal_service_code: "ME",
            location_postal_code: "01234"
          }
      }
    end

    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end

    context 'with only optional parameters' do
      it 'should contain all optional keys and values' do
        result = described_class.new(optional_params)
        expect(result.to_h).to eq optional_params
      end
    end
  end
end

