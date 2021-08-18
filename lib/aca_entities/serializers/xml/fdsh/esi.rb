# frozen_string_literal: true

require "happymapper"

require_relative 'esi/h14/person_name'
require_relative 'esi/h14/person_birth_date'
require_relative 'esi/h14/person_ssn_identification'
require_relative 'esi/h14/request_person'
require_relative 'esi/h14/start_date'
require_relative 'esi/h14/end_date'
require_relative 'esi/h14/insurance_applicant_requested_coverage'
require_relative 'esi/h14/insurance_applicant_request'
require_relative 'esi/h14/applicant_request'
require_relative 'esi/h14/esi_mec_request'
require_relative 'esi/h14/employee_premium_amount'
require_relative 'esi/h14/family_premium_amount'
require_relative 'esi/h14/monthly_premium_amount'
require_relative 'esi/h14/insurance_applicant_response'
require_relative 'esi/h14/applicant_mec_information'
require_relative 'esi/h14/response_meta_data'
require_relative 'esi/h14/response_person'
require_relative 'esi/h14/applicant_response'
require_relative 'esi/h14/applicant_response_set'
require_relative 'esi/h14/esi_mec_response'

# operations
require_relative "esi/h14/operations/validate_esi_payload_xml"
require_relative "esi/h14/operations/esi_request_to_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Esi objects.
        module Esi
        end
      end
    end
  end
end