# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_employment_association_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::PersonEmploymentAssociationContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { start_date: start_date,
      end_date: end_date,
      employer: employer
    }
  end

  let(:start_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2020",
      year_month: "12/2020"
    }
  end

  let(:end_date) do
    { date: Date.today,
      date_time: DateTime.now,
      year: "2021",
      year_month: "12/2021"
    }
  end

  let(:employer) do
    { id: "em123",
      category_text: "Acme",
      organization_primary_contact_information: contact_information
    }
  end

  let(:contact_information) do
    { email: "fake@test.com",
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

  context 'invalid parameters' do
    context 'with empty parameters' do
      it 'should list error for every required parameter' do
        expect(subject.call({}).errors.to_h.keys).to match_array required_params.keys
      end
    end
  end

  context 'valid parameters' do
    context 'with required parameters only' do
      let(:input_params) { {} }

      before do
        @result = subject.call(input_params)
      end

      it { expect(@result.success?).to be_truthy }
      it { expect(@result.to_h).to eq input_params }
    end

    context 'with all required and optional parameters' do
      it 'should pass validation' do
        result = subject.call(all_params)
        expect(result.success?).to be_truthy
        expect(result.to_h).to eq all_params
      end
    end
  end
end
