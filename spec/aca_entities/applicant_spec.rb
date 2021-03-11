# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/person_name'
require 'aca_entities/address'
require 'aca_entities/demographic'
require 'aca_entities/identifying_information'
require 'aca_entities/identifying_numbers_from_document'
require 'aca_entities/citizenship_immigration_status_information'
require 'aca_entities/immigration_document'
require 'aca_entities/native_american_information'
require 'aca_entities/employer_sponsored_insurance_information'
require 'aca_entities/lowest_cost_plan'
require 'aca_entities/current_income'
require 'aca_entities/ssa_income_information'
require 'aca_entities/ssa_information'
require 'aca_entities/ssa_work_quarter'
require 'aca_entities/medicaid_specific_information'
require 'aca_entities/other_insurance_coverage_information'
require 'aca_entities/other_insurance_detail'
require 'aca_entities/person_description_identifier'
require 'aca_entities/attestation'
require 'aca_entities/dhs_save'
require 'aca_entities/coverage_specific_information'
require 'aca_entities/coverage_period'
require 'aca_entities/relationship'
require 'aca_entities/foster_care'
require 'aca_entities/basis_for_outcome'
require 'aca_entities/applicant'

RSpec.describe ::AcaEntities::Applicant, dbclean: :after_each do
  let(:required_params) do
    { person_name: { first_name: 'ivl40', last_name: '41' },
      demographic: { dob: Date.new(2000, 1, 1), gender: 'Male' },
      citizenship_immigration_status_information: { us_citizen: true },
      native_american_information: { is_native_american_or_alaska_native: false } }
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
