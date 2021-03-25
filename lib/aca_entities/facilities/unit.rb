# frozen_string_literal: true

module AcaEntities
  module Facilities
    # The usable spaces within a facility, which often have equipment, people, schedules, or
    # other assets associated with them.
    class Unit < Dry::Struct
      UnitKinds = [:office, :conference_room].freeze

      attribute :name,            Types::String.meta(omittable: true).meta(omittable: true)
      attribute :door_details,    Types::Array.of(Facilities::Detail).meta(omittable: true)
      attribute :window_details,  Types::Array.of(Facilities::Detail).meta(omittable: true)
    end
  end
end
