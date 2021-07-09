# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TransferHeader information
      class TransferHeader < Dry::Struct
        attribute :transfer_activity,     TransferActivity.meta(omittable: false)
        attribute :recipient_state_code,  Types::String.optional.meta(omittable: true)
      end
    end
  end
end
