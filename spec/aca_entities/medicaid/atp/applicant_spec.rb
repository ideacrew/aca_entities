# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/person_name'
require 'aca_entities/medicaid/atp/address'
require 'aca_entities/medicaid/atp/demographic'
require 'aca_entities/medicaid/atp/identifying_information'
require 'aca_entities/medicaid/atp/identifying_numbers_from_document'
require 'aca_entities/medicaid/atp/citizenship_immigration_status_information'
require 'aca_entities/medicaid/atp/immigration_document'
require 'aca_entities/medicaid/atp/native_american_information'
require 'aca_entities/medicaid/atp/employer_sponsored_insurance_information'
require 'aca_entities/medicaid/atp/lowest_cost_plan'
require 'aca_entities/medicaid/atp/current_income'
require 'aca_entities/medicaid/atp/ssa_income_information'
require 'aca_entities/medicaid/atp/ssa_information'
require 'aca_entities/medicaid/atp/ssa_work_quarter'
require 'aca_entities/medicaid/atp/medicaid_specific_information'
require 'aca_entities/medicaid/atp/other_insurance_coverage_information'
require 'aca_entities/medicaid/atp/other_insurance_detail'
require 'aca_entities/medicaid/atp/person_description_identifier'
require 'aca_entities/medicaid/atp/attestation'
require 'aca_entities/medicaid/atp/dhs_save'
require 'aca_entities/medicaid/atp/coverage_specific_information'
require 'aca_entities/medicaid/atp/coverage_period'
require 'aca_entities/medicaid/atp/relationship'
require 'aca_entities/medicaid/atp/foster_care'
require 'aca_entities/medicaid/atp/basis_for_outcome'
require 'aca_entities/medicaid/atp/applicant'

RSpec.describe ::AcaEntities::Medicaid::Atp::Applicant, dbclean: :after_each do
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
