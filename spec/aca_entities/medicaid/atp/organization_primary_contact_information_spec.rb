# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/full_telephone'
require 'aca_entities/medicaid/atp/structured_address'
require 'aca_entities/medicaid/atp/organization_primary_contact_information'

RSpec.describe ::AcaEntities::Medicaid::Atp::FullTelephone,  dbclean: :around_each do
  
  describe 'with valid arguments' do
    let(:required_params) { {} }

    let(:optional_params) do
      { email_id: "fake@test.com",
        mailing_address: structured_address,
        telephone_number: full_telephone
      }
    end

    let(:structured_address) do
      { location_street: { street_full_text: "123 Easy Street" },
      address_secondary_unit_text: "address",
      location_city_name: "Wheaton",
      location_county_name: "Montgomery", 
      location_county_code: "code",
      location_state_us_postal_service_code: "ME",
      location_postal_code: "01234"
    }
    end

    let(:full_telephone) do
      { telephone_number_full_id: "1231231234",
        telephone_suffix_id: "0"
      }
    end
 
    let(:all_params) { required_params.merge(optional_params)}

    it 'should initialize' do
      expect(described_class.new(all_params)).to be_a described_class
    end

    it 'should not raise error' do
      expect { described_class.new(all_params) }.not_to raise_error
    end
  end  
end

