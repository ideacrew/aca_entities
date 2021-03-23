# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      class GeocodeResponse < Dry::Struct

        attribute :status, Types::String.meta(omittable: false)

        attribute :results, Types::Array do

          attribute :formatted_address, Types::String.meta(omittable: true)

          attribute :geometry do
            attribute :location,        Google::LatLng.meta(omittable: true)
            attribute :location_type,   Types::String.meta(omittable: true)
            attribute :viewport,        Google::Viewport.meta(omittable: true)
          end

          attribute :place_id,          Types::String.meta(omittable: true)

          attribute :plus_code do
            attribute :compound_code,   Types::String.meta(omittable: true)
            attribute :global_code,     Types::String.meta(omittable: true)
          end
          attribute :types,             Types::Array.of(Types::String).meta(omittable: true)

          attribute :address_components, Types::Array do
            attribute :long_name,       Types::String.meta(omittable: true)
            attribute :short_name,      Types::String.meta(omittable: true)
            attribute :types,           Types::Array.of(Types::String).meta(omittable: true)
          end

        end

      end
    end
  end
end
