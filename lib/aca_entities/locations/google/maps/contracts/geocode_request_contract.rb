# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        # Schema and validation rules for the {AcaEntities::Locations::Google::Maps::GeocodeRequest} entity
        class GeocodeRequestContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :key required
          # @option opts [String] :address required
          # @return [Dry::Monads::Result] result

          params do
            required(:key).filled(:string)
            required(:address).filled(:string)
          end
        end
      end
    end
  end
end
