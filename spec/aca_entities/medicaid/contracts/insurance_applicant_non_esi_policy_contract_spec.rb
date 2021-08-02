# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/contracts/insurance_applicant_non_esi_policy_contract'

RSpec.describe ::AcaEntities::Medicaid::Contracts::InsuranceApplicantNonEsiPolicyContract, dbclean: :after_each do

  it 'should inherit from InsurancePolicyContract class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Contracts::InsurancePolicyContract
  end
end
