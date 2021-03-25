# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      class LatLng < Dry::Struct

        attribute :lat, Google::Types::LatitudeKind.meta(omittable: false)
        attribute :lng, Google::Types::LongitudeKind.meta(omittable: false)

      end
    end
  end
end
