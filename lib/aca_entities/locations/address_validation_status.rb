# frozen_string_literal: true

module AcaEntities
  module Locations
    class AddressValidationStatus < Dry::Struct
      attribute :id, Types::String.optional.meta(omittable: true)

      # TODO: point this to a settings list of address validation organizations
      attribute :authority, Types::String.optional.meta(omittable: false)
      attribute :validated_on, Types::Date.meta(omittable: false)
      attribute :payload, Types::String.meta(omittable: true)
      attribute :timestamps, AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end
