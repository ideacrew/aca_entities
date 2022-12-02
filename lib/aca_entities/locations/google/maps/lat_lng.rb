# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        class LatLng < Dry::Struct
          attribute :lat, Google::Maps::Types::LatitudeKind.meta(omittable: false)
          attribute :lng, Google::Maps::Types::LongitudeKind.meta(omittable: false)
        end
      end
    end
  end
end
