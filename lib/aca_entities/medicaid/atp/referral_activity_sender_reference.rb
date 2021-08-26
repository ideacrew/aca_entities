# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for ReferralActivitySenderReference
      class ReferralActivitySenderReference < Dry::Struct
        attribute :ref, Types::String.meta(omittable: false)
      end
    end
  end
end
