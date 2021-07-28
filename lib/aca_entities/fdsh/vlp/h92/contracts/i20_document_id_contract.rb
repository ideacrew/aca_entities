# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I20DocumentId
        class I20DocumentIdContract < Dry::Validation::Contract
          params do
            required(:SEVISID).filled(:string)
            optional(:I94Number).maybe(:string)
            optional(:PassportCountry).maybe(Fdsh::Vlp::H92::PassportCountryContract.params)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end