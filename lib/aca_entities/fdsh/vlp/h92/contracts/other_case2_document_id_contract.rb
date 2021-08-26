# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp OtherCase2DocumentId
        class OtherCase2DocumentIdContract < Dry::Validation::Contract
          params do
            required(:I94Number).filled(:string)
            required(:DocDescReq).filled(:string)
            optional(:PassportCountry).maybe(Fdsh::Vlp::H92::PassportCountryContract.params)
            optional(:SEVISID).maybe(:string)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end