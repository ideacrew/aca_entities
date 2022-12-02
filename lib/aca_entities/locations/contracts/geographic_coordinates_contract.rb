# frozen_string_literal: true

module AcaEntities
  module Locations
    module Contracts
      # Schema and validation rules for the {AcaEntities::Locations::GeographicCoodinates} entity
      class GeographicCoordinates < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @opts [AcaEntities::Locations::Types::LatitudeKind] :lat a global latitude value in decimal degrees
        # @opts [AcaEntities::Locations::Types::LongitudeKind] :long a global longitude value in decimal degrees
        # @return [Dry::Monads::Result::Success | Dry::Monads::Result::Failure] params pass or fail validation
        params do
          required(:latitude).value(AcaEntities::Locations::Types::LatitudeKind)
          required(:longitude).value(AcaEntities::Locations::Types::LongitudeKind)
        end
      end
    end
  end
end
