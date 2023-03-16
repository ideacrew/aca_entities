# frozen_string_literal: true

require "happymapper"

require_relative "care_first/member_name"
require_relative "care_first/primary"
require_relative "care_first/member"
require_relative "care_first/members"
require_relative "care_first/pay_now_transfer_payload"

# operations
require_relative 'care_first/operations/validate_pay_now_transfer_payload_saml'

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        # XML serialization for CareFirst Pay Now objects.
        module CareFirst
        end
      end
    end
  end
end