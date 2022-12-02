# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Locations
    module Google
      module Maps
        module Types
          send(:include, Dry.Types)
          include Dry::Logic

          MapTypeIdKind = Types::Coercible::String.enum('HYBRID', 'ROADMAP', 'SATELLITE', 'TERRAIN')

          # @see: https://dry-rb.org/gems/dry-types/1.2/enum/
          # ZoomKind      = Types::Symbol.enum(world: 1, continent: 5, city: 10, streets: 15, buildings: 20)
          ZoomKind = Types::Integer.constrained(gteq: 1, lteq: 20)

          LatitudeKind = Types::Coercible::Float.constrained(gteq: -90.0, lteq: 90.0)
          LongitudeKind = Types::Coercible::Float.constrained(gteq: -180.0, lteq: 180.0)
        end
      end
    end
  end
end
