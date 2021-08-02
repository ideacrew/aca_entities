# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/insurance_policy_applied_effective_date_range'
require 'aca_entities/medicaid/atp/insurance_premium'
require 'aca_entities/medicaid/atp/medicaid_identification'
require 'aca_entities/medicaid/atp/chip_identification'
require 'aca_entities/medicaid/atp/insurance_member'
require 'aca_entities/medicaid/atp/insurance_policy_identification'
require 'aca_entities/medicaid/atp/insurance_policy'
require 'aca_entities/medicaid/atp/insurance_applicant_non_esi_policy'

RSpec.describe ::AcaEntities::Medicaid::Atp::InsuranceApplicantNonEsiPolicy,  dbclean: :around_each do

  it 'should inherit from InsurancePolicy class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Atp::InsurancePolicy
  end
end

