# frozen_string_literal: true

module Facilities

  # Collection of units on a level. Zones may define security, access, or the extent of
  # facility systems, such as HVAC or sprinkler coverage.
  class Zone < Dry::Struct

    attribute :name, Types::String.meta(omittable: true).meta(omittable: true)
    attribute :units, Types::Array.of(Facilities::Unit).meta(omittable: true)

  end
end
