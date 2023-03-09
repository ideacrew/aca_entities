# frozen_string_literal: true

require "happymapper"
# can remove coverage_kind since serializer not needed
require_relative "care_first/coverage_kind"
require_relative "care_first/member_name"
require_relative "care_first/primary"
require_relative "care_first/member"
require_relative "care_first/pay_now_transfer_payload"

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