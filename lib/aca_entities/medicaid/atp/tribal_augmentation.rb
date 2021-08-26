# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp TribalAugmentation
      class TribalAugmentation < Dry::Struct

        attribute :recognized_tribe_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :american_indian_or_alaska_native_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :person_tribe_name, Types::String.optional.meta(omittable: true)
        attribute :location_state_us_postal_service_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end