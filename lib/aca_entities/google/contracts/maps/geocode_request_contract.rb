# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      # contract for google maps Geocode request
      class GeocodeRequestContract < Dry::Validation::Contract

        params do
          required(:key).filled(:string)
          required(:address).filled(:string)
        end

      end
    end
  end
end
