# frozen_string_literal: true

require "happymapper"

require_relative "mec_check/person_name"
require_relative "mec_check/requested_insurance_period"
require_relative "mec_check/non_esi_mec_individual_information"
require_relative "mec_check/non_esi_mec_request"
require_relative "mec_check/verify_non_esi_mec_request"

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        # XML serialization for MEC Check objects.
        module MecCheck
        end
      end
    end
  end
end