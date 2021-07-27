# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp UnexpForeignPassportDocumentId
        class UnexpForeignPassportDocumentIdContract < Dry::Validation::Contract
          params do
            required(:PassportNumber).filled(:string)
            required(:CountryOfIssuance).filled(:string)
            required(:DocExpirationDate).filled(:date)
            optional(:I94Number).maybe(:string)
            optional(:SEVISID).maybe(:string)
          end
        end
      end
    end
  end
end