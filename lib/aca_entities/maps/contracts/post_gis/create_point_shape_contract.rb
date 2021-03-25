# frozen_string_literal: true

module AcaEntities
  module Maps
    module PostGis

      # Schema and validation rules for the {Google::Maps::CreateConfigContract} operation
      class CreatePointShapeContract < Dry::Validation::Contract

        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Google::Maps::Types::LatitudeKind] :lat required
        # @option opts [Google::Maps::Types::LongitudeKind] :lng required
        # @return [Dry::Monads::Result] result
        params do
          required(:lat).filled(Google::Maps::Types::LatitudeKind)
          required(:lng).filled(Google::Maps::Types::LongitudeKind)
        end
      end
    end
  end
end