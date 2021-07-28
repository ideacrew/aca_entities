# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp Ds2019DocumentId
        class Ds2019DocumentIdContract < Dry::Validation::Contract
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