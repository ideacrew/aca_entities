# frozen_string_literal: true

module AcaEntities
  # Entity for Sender information
  class Sender < Dry::Struct
    attribute :sender_code,                          Types::String.optional.meta(omittable: true)
    attribute :sender_medicaid_chip_state,           Types::String.optional.meta(omittable: true)
    attribute :sender_medicaid_chip_county,          Types::String.optional.meta(omittable: true)
  end
end