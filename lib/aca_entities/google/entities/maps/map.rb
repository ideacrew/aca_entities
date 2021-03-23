# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      # google maps entity
      class Map < Dry::Struct

        ZoomKind = [].freeze

        # 1: World
        # 5: Landmass/continent
        # 10: City
        # 15: Streets
        # 20: Buildings

        attribute :center,              Google::Maps::LatLng.meta(omittable: false)
        attribute :zoom,                Types::Coercible::Integer.meta(omittable: false)

        # attribute :street_view_control, Types::Bool.meta(omittable: false)
        # attribute :map_type_id,         Google::Maps::Types::MapTypeIdKind.meta(omittable: true)

        # attribute :restrictions,        Google::Maps::Restriction.meta(omittable: true)
      end

      # google maps data entity
      class Data < Dry::Struct

      end

      # google MapTypeControlOption entity
      class MapTypeControlOption < Dry::Struct
        attribute :map_type_ids,  Types::Array.of(String).meta(omittable: true)
      end

      # google place entity
      class Place < Dry::Struct
      end

      # google Infowindow entity
      class InfoWindow < Dry::Struct
        attribute :content,   Types::String.meta(omittable: false)
        attribute :max_width, Types::Coercible::Integer.meta(omittable: false)
      end

      # google market entity
      class Marker < Dry::Struct
        attribute :map,       Google::Maps::Map.meta(omittable: true)
        # attribute :position,  Locations::Coordinate.meta(omittable: true)
        # attribute :label
        # attribute :icon
        # attribute :shape
        # attribute :title
        # attribute :z_index
      end
    end
  end
end
