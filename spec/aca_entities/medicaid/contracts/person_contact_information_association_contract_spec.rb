# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/person_contact_information_association_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::PersonContactInformationAssociationContract, dbclean: :after_each do

  let(:required_params) { {} }

  let(:optional_params) do
    { contact:
      { contact_email_id: "fake@test.com",
        mailing_address:
          { location_street: { street_full_text: "123 Easy Street" },
            address_secondary_unit_text: "address",
            location_city_name: "Wheaton",
            location_county_name: "Montgomery",
            location_county_code: "code",
            location_state_us_postal_service_code: "ME",
            location_postal_code: "01234" },
        telephone_number:
          { telephone_number_full_id: "1231231234",
            telephone_suffix_id: "0" } },
      category_code: "Home" }
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
