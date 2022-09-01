# frozen_string_literal: true

require "happymapper"

require_relative 'insurance'
require_relative 'insurance_policy'
require_relative 'person_name'
require_relative 'person_birth_date'
require_relative 'applicant'
require_relative 'individual_response'
require_relative 'individual_responses'
require_relative 'individual_request'
require_relative 'individual_requests'
require_relative 'ees_dsh_batch_response_data'
require_relative 'ees_dsh_batch_request_data'

# operations
require_relative 'operations/medicare_request_to_xml'
require_relative 'operations/validate_medicare_request_payload_xml'
require_relative 'operations/validate_medicare_response_payload_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Pvc objects.
        module Medicare
        end
      end
    end
  end
end