# frozen_string_literal: true

require "happymapper"

require_relative 'rrv/medicare/insurance'
require_relative 'rrv/medicare/insurance_policy'
require_relative 'rrv/medicare/person_name'
require_relative 'rrv/medicare/person_birth_date'
require_relative 'rrv/medicare/applicant'
require_relative 'rrv/medicare/individual_response'
require_relative 'rrv/medicare/individual_responses'
require_relative 'rrv/medicare/individual_request'
require_relative 'rrv/medicare/individual_requests'
require_relative 'rrv/medicare/ees_dsh_batch_response_data'
require_relative 'rrv/medicare/ees_dsh_batch_request_data'

# operations
require_relative 'rrv/medicare/operations/medicare_request_to_xml'
require_relative 'rrv/medicare/operations/validate_medicare_request_payload_xml'
require_relative 'rrv/medicare/operations/validate_medicare_response_payload_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Rrv objects.
        module Rrv
        end
      end
    end
  end
end