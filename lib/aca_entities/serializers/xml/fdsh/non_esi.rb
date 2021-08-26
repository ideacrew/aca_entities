# frozen_string_literal: true

require "happymapper"

require_relative 'non_esi/h31/person_name'
require_relative 'non_esi/h31/person_birth_date'
require_relative 'non_esi/h31/insurance_policy_expiration_date'
require_relative 'non_esi/h31/insurance_policy_effective_date'
require_relative 'non_esi/h31/organization'
require_relative 'non_esi/h31/insurance_policy'
require_relative 'non_esi/h31/applicant'
require_relative 'non_esi/h31/individual_request'
require_relative 'non_esi/h31/verify_non_esi_mec_request'
require_relative 'non_esi/h31/response_metadata'
require_relative 'non_esi/h31/insurance_effective_date'
require_relative 'non_esi/h31/insurance_end_date'
require_relative 'non_esi/h31/insurance'
require_relative 'non_esi/h31/mec_coverage'
require_relative 'non_esi/h31/other_coverage'
require_relative 'non_esi/h31/individual_response'
require_relative 'non_esi/h31/individual_response_set'
require_relative 'non_esi/h31/verify_non_esi_mec_response'

# operations
require_relative "non_esi/h31/operations/validate_non_esi_payload_xml"
require_relative "non_esi/h31/operations/non_esi_request_to_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Esi objects.
        module NonEsi
        end
      end
    end
  end
end