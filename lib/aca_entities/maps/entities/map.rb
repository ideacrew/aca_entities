# frozen_string_literal: true

module AcaEntities
  module Maps
    # entity for map
    class Map < Dry::Struct
      Options = {
        'marker_cluster_image_source' => 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m',
        'controls' => [],
        'marker_layer' => nil,
        'data_layer' => nil
      }.freeze

      attribute :center,    Google::Maps::Center.meta(omittable: false)
      attribute :zoom,      Types::Integer.meta(omittable: false)
      attribute :type,      Google::Maps::Types::MapTypeIdKind.meta(omittable: true)

      attribute :pitch,     Types::Integer.default(0).meta(omittable: true)
      attribute :bearing,   Types::Integer.default(0).meta(omittable: true)
      attribute :options,   Types::Hash.default(Options).meta(omittable: true)
      attribute :meta,      Maps::Meta.meta(omittable: true)
    end

  end
end
