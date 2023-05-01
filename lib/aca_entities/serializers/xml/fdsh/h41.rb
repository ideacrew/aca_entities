# frozen_string_literal: true

require "happymapper"

require_relative 'h41/annual_policy_total_amount'
require_relative 'h41/monthly_premium_information'
require_relative 'h41/recipient_policy_information'
require_relative 'h41/other_complete_person_name'
require_relative 'h41/insured_person'
require_relative 'h41/us_address_group'
require_relative 'h41/covered_individual'
require_relative 'h41/coverage_household_group'
require_relative 'h41/recipient_spouse'
require_relative 'h41/recipient'
require_relative 'h41/policy'
require_relative 'h41/form_1095_a_upstream_detail'
require_relative 'h41/form_1095_a_transmission_upstream'

require_relative 'h41/checksum_augmentation'
require_relative 'h41/document_binary'
require_relative 'h41/attachment'
require_relative 'h41/report_period'
require_relative 'h41/service_specific_data'
require_relative 'h41/transmission_metadata'
require_relative 'h41/batch_metadata'
require_relative 'h41/batch_handling_service_request'

# operations
require_relative "h41/operations/validate_h41_request_payload_xml"
require_relative "h41/operations/validate_h41_manifest_xml"
require_relative "h41/operations/create_h41_manifest_xml"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for H41 objects.
        module H41
        end
      end
    end
  end
end
