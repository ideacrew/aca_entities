# frozen_string_literal: true

# types
require 'aca_entities/types'

# contracts
require_relative 'ssa/h3/contracts/person_contract'
require_relative 'ssa/h3/contracts/ssa_composite_individual_request_contract'
require_relative 'ssa/h3/contracts/ssa_composite_request_contract'
require_relative 'ssa/h3/contracts/qualifying_year_and_quarter_contract'
require_relative 'ssa/h3/contracts/ssa_quarters_of_coverage_contract'
require_relative 'ssa/h3/contracts/title_ii_requested_year_information_contract'
require_relative 'ssa/h3/contracts/ssa_title_ii_yearly_income_contract'
require_relative 'ssa/h3/contracts/requested_month_information_contract'
require_relative 'ssa/h3/contracts/ssa_title_ii_monthly_income_contract'
require_relative 'ssa/h3/contracts/facility_contact_information_contract'
require_relative 'ssa/h3/contracts/facility_location_contract'
require_relative 'ssa/h3/contracts/supervision_facility_contract'
require_relative 'ssa/h3/contracts/ssa_incarceration_information_contract'
require_relative 'ssa/h3/contracts/ssa_response_contract'
require_relative 'ssa/h3/contracts/response_meta_data_contract'
require_relative 'ssa/h3/contracts/ssa_composite_individual_response_contract'
require_relative 'ssa/h3/contracts/ssa_composite_response_contract'

# entities
require_relative 'ssa/h3/person'
require_relative 'ssa/h3/ssa_composite_individual_request'
require_relative 'ssa/h3/ssa_composite_request'
require_relative 'ssa/h3/qualifying_year_and_quarter'
require_relative 'ssa/h3/ssa_quarters_of_coverage'
require_relative 'ssa/h3/title_ii_requested_year_information'
require_relative 'ssa/h3/ssa_title_ii_yearly_income'
require_relative 'ssa/h3/requested_month_information'
require_relative 'ssa/h3/ssa_title_ii_monthly_income'
require_relative 'ssa/h3/facility_contact_information'
require_relative 'ssa/h3/facility_location'
require_relative 'ssa/h3/supervision_facility'
require_relative 'ssa/h3/ssa_incarceration_information'
require_relative 'ssa/h3/ssa_response'
require_relative 'ssa/h3/response_meta_data'
require_relative 'ssa/h3/ssa_composite_individual_response'
require_relative 'ssa/h3/ssa_composite_response'

# operations
require_relative 'ssa/h3/operations/ssa_verification_request'

# happymapper
require 'aca_entities/serializers/xml/fdsh/ssa'

