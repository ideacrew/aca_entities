# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        module Contracts
          # Schema and validation rules for the {AcaEntities::Locations::Google::Maps::LatLng} entity
          class LatLng < Contract
            # @!method call(opts)
            # @param [Hash] opts the parameters to validate using this contract
            # @return [Dry::Monads::Result::Success] if params pass validation
            # @return [Dry::Monads::Result::Failure] if params fail validation
            params do
              required(:lat).value(AcaEntities::Locations::Google::Maps::Types::LatitudeKind)
              required(:lng).value(AcaEntities::Locations::Google::Maps::Types::LongitudeKind)
            end
          end
        end
      end
    end
  end
end
