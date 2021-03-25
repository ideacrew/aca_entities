# frozen_string_literal: true

module AcaEntities
  module Facilities
    # Interior details that show the partitioning of spaces and entry/exit locations for
    # each unit and facility, such as the location of walls, doors, windows, and so on, on
    # an indoor map
    class Detail < Dry::Struct
      DetailKinds = [:door, :window].freeze

      attribute :name, Types::String.meta(omittable: true).meta(omittable: true)
    end
  end
end
