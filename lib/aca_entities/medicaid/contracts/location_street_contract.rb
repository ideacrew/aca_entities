# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for LocationStreet
      class LocationStreetContract < Dry::Validation::Contract

        params do
          optional(:street_full_text).maybe(:string)
        end
      end
    end
  end
end
