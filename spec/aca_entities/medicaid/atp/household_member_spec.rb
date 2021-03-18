# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/identifying_information'
require 'aca_entities/medicaid/atp/demographic'
require 'aca_entities/medicaid/atp/pregnancy_information'
require 'aca_entities/medicaid/atp/current_income_information'
require 'aca_entities/medicaid/atp/current_deduction_information'
require 'aca_entities/medicaid/atp/current_income'
require 'aca_entities/medicaid/atp/current_income_employer'
require 'aca_entities/medicaid/atp/pay_period_information'
require 'aca_entities/medicaid/atp/relationship'
require 'aca_entities/medicaid/atp/household_member'

RSpec.describe ::AcaEntities::Medicaid::Atp::HouseholdMember, dbclean: :after_each do
  let(:required_params) do
    { person_name: { first_name: 'ivl40', last_name: '41' },
      demographic: { dob: Date.new(2000, 1, 1), gender: 'Male' },
      relationships: [{ is_member_of_applicants_medicaid_household: false }] }
  end

  context 'invalid params' do
    context 'with empty params' do
      it 'should raise error' do
        expect {subject}.to raise_error(Dry::Struct::Error, /:first_name is missing in Hash input/)
      end
    end
  end

  context 'valid params' do
    context 'required params only' do
      it { expect(described_class.new(required_params).to_h).to eq required_params }
    end
  end
end
