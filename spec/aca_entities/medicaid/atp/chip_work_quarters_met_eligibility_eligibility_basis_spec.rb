# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/medicaid/atp/types'
require 'aca_entities/medicaid/atp/activity_date'
require 'aca_entities/medicaid/atp/activity_identification'
require 'aca_entities/medicaid/atp/start_date'
require 'aca_entities/medicaid/atp/end_date'
require 'aca_entities/medicaid/atp/status_valid_date_range'
require 'aca_entities/medicaid/atp/eligibility_basis_determination'
require 'aca_entities/medicaid/atp/eligibility_basis'
require 'aca_entities/medicaid/atp/chip_work_quarters_met_eligibility_basis'

RSpec.describe ::AcaEntities::Medicaid::Atp::ChipWorkQuartersMetEligibilityBasis,  dbclean: :around_each do

  it 'should inherit from EligibilityBasis class' do
    expect(described_class).to be < ::AcaEntities::Medicaid::Atp::EligibilityBasis
  end
end
