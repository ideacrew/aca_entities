# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp PassportCountryType
          class PassportCountryTypeContract < Dry::Validation::Contract
            params do
              required(:passportNumber).filled(:string)
              required(:countryOfIssuance).filled(:string)
            end
          end
        end
      end
    end
  end
end