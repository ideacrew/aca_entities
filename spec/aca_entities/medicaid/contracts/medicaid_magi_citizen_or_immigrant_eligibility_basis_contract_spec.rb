# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/medicaid_magi_citizen_or_immigrant_eligibility_basis_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::MedicaidMagiCitizenOrImmigrantEligibilityBasisContract, dbclean: :around_each do

  it 'should inherit from EligibilityBasisContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::EligibilityBasisContract
  end
end

