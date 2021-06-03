# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for StructuredAddressType
        class StructuredAddressType < Dry::Struct

          attribute :location_street,                        Types::String.optional.meta(omittable: true)
          attribute :location_city_name,                     Types::String.optional.meta(omittable: true)
          attribute :location_state_uspostal_service_code,
                    AcaEntities::Fdsh::Ridp::H139::Types::UsStateAbbreviationKind.optional.meta(omittable: true)
          attribute :location_postal_code,                   Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end