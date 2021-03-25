# frozen_string_literal: true

module AcaEntities
  module Maps
    # A collection of component Features
    class Layer < Dry::Struct
      Options = {
        'clickable' => true,
        'cursor' => "",
        'draggable' => false,
        'editable' => false,
        'visible' => true
      }.freeze

      attribute :key,             Types::Symbol.meta(omittable: false)
      attribute :title,           Types::String.meta(omittable: true)
      attribute :feature_groups,  Types::Array.of(FeatureGroup).meta(omittable: true)
      attribute :z_index,         Types::Integer.meta(omittable: true)
      attribute :options,         Types::Hash.default(Options)
    end
  end
end
