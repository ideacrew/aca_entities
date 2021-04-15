# frozen_string_literal: true

module AcaEntities
  module Facilities
    # Each level of a facility
    class Level < Dry::Struct

      attribute :name,            Types::String.meta(omittable: true).meta(omittable: true)
      attribute :sections,        Types::Array.of(Facilities::Section).meta(omittable: true)

      attribute :hvac_zones,      Types::Array.of(Facilities::Zone).meta(omittable: true)
      attribute :security_zones,  Types::Array.of(Facilities::Zone).meta(omittable: true)
    end
  end
end
