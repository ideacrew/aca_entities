# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/chip_medicaid_residency_eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::ChipMedicaidResidencyEligibilityBasisContract,  dbclean: :around_each do

  it 'should inherit from EligibilityBasisContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::EligibilityBasisContract
  end
end

