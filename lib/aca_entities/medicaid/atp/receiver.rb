# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp  Receiver information
      class Receiver < Dry::Struct
        attribute :category_code,                           Types::String.meta(omittable: false)
        attribute :recipient_medicaid_chip_state,           Types::String.optional.meta(omittable: true)
        attribute :recipient_medicaid_chip_county,          Types::String.optional.meta(omittable: true)
      end
    end
  end
end