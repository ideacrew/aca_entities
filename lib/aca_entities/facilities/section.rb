# frozen_string_literal: true

module AcaEntities
  module Facilities
    # Collection of units that include a logical subdivision of a level. Unlike in zones,
    # units typically belong to only one section, for example, the West Wing
    class Section < Dry::Struct

      attribute :name,  Types::String.meta(omittable: true).meta(omittable: true)
      attribute :units, Types::Array.of(Facilities::Unit).meta(omittable: true)

    end
  end
end