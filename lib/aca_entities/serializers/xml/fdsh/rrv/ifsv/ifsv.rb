# frozen_string_literal: true

require "happymapper"

require_relative 'ifsv_response_code_detail'
require_relative 'ifsv_applicant_verification'
require_relative 'ifsv_dependent_verification'
require_relative 'error_message_detail'
require_relative 'complete_person_name'
require_relative 'ifsv_applicant'
require_relative 'ifsv_applicant_request_group'
require_relative 'ifsv_applicant_response_group'
require_relative 'verify_household_income_and_family_size_bulk_request'
require_relative 'verify_household_income_and_family_size_bulk_response'

# operations
require_relative 'operations/ifsv_request_to_xml'
require_relative 'operations/validate_ifsv_request_payload_xml'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for Rrv objects.
        module Ifsv
        end
      end
    end
  end
end