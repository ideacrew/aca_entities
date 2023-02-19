# frozen_string_literal: true

require "happymapper"

require_relative "h36/us_address_group"
require_relative "h36/complete_person_name"
require_relative "h36/insured_person"
require_relative "h36/covered_individual"
require_relative "h36/insurance_coverage"
require_relative "h36/person_address_group"
require_relative "h36/dependent_person"
require_relative "h36/dependent_group"
require_relative "h36/spouse"
require_relative "h36/spouse_group"
require_relative "h36/primary"
require_relative "h36/primary_group"
require_relative "h36/associated_policy"
require_relative "h36/household"
require_relative "h36/other_relevant_adult"
require_relative "h36/tax_household_coverage"
require_relative "h36/tax_household"
require_relative "h36/insurance_policy"
require_relative "h36/irs_household_group"
require_relative "h36/individual_exchange"
require_relative "h36/health_exchange"

require_relative 'h36/checksum_augmentation'
require_relative 'h36/document_binary'
require_relative 'h36/attachment'
require_relative 'h36/report_period'
require_relative 'h36/service_specific_data'
require_relative 'h36/transmission_metadata'
require_relative 'h36/batch_metadata'
require_relative 'h36/batch_handling_service_request'

# operations
require_relative "h36/operations/create_h36_manifest_file"
require_relative "h36/operations/validate_h36_request_payload"

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for h36 objects.
        module H36
        end
      end
    end
  end
end
