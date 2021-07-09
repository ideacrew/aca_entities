# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for ReferralActivityReceiverReference
      class ReferralActivityReceiverReference < Dry::Struct
        attribute :ref, Types::String.meta(omittable: false)
      end
    end
  end
end
