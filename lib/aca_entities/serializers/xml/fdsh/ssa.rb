# frozen_string_literal: true

require "happymapper"

require_relative 'ssa/h3/person_name'
require_relative 'ssa/h3/person_birth_date'
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
require_relative "vlp/h92/operations/validate_vlp_h92_payload_xml"
require_relative "vlp/h92/operations/initial_request_to_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Ssa objects.
        module Ssa
        end
      end
    end
  end
end