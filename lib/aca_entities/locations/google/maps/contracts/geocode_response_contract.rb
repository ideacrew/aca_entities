# frozen_string_literal: true

module AcaEntities
  module Locations
    module Google
      module Maps
        # Schema and validation rules for the {AcaEntities::Locations::Google::Maps::GeocodeResponse} entity
        class GeocodeResponseContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :status required
          # @option opts [Arry<Hash>] :results
          # @return [Dry::Monads::Result] result

          json do
            required(:status).filled(:string)
            optional(:results)
              .array(:hash) do
                optional(:address_components)
                  .array(:hash) do
                    optional(:long_name).maybe(:string)
                    optional(:short_name).maybe(:string)
                    optional(:types).array(:string)
                  end

                optional(:formatted_address).maybe(:string)

                optional(:geometry).hash do
                  optional(:location).maybe(:hash)
                  optional(:location_type).maybe(:string)
                  optional(:viewport).maybe(:hash)
                end

                optional(:place_id).maybe(:string)

                optional(:plus_code).hash do
                  optional(:compound_code).maybe(:string)
                  optional(:global_code).maybe(:string)
                end

                optional(:types).array(:string)
              end
          end
        end
      end
    end
  end
end
