# frozen_string_literal: true

require "happymapper"

require_relative "atp/activity_identification"
require_relative "atp/activity_date"
require_relative "atp/transfer_activity"
require_relative "atp/transfer_header"
require_relative "atp/sender"
require_relative "atp/receiver"
require_relative "atp/application_creation"
require_relative "atp/application_submission"
require_relative "atp/application_identification"
require_relative "atp/role_of_person_reference"
require_relative "atp/ssf_primary_contact"
require_relative "atp/insurance_applicant"
require_relative "atp/insurance_application"
require_relative "atp/person_name"
require_relative "atp/person"
require_relative "atp/physical_household"
require_relative "atp/account_transfer_request"

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        # XML serialization for Account Transfer Protocol (ATP) objects.
        module Atp
        end
      end
    end
  end
end