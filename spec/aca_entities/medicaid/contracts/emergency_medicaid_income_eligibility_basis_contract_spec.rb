# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/emergency_medicaid_income_eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::EmergencyMedicaidIncomeEligibilityBasisContract,  dbclean: :around_each do

  it 'should inherit from EligibilityBasisContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::EligibilityBasisContract
  end
end

