# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp PassportCountry
        class PassportCountryContract < Dry::Validation::Contract
          params do
            required(:PassportNumber).maybe(:string)
            required(:CountryOfIssuance).maybe(:string)
          end
        end
      end
    end
  end
end