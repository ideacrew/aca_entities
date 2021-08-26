# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I94UnexpForeignPassportDocumentId
        class I94UnexpForeignPassportDocumentIdContract < Dry::Validation::Contract
          params do
            required(:I94Number).filled(:string)
            required(:PassportNumber).filled(:string)
            required(:CountryOfIssuance).filled(:string)
            required(:DocExpirationDate).filled(:date)
            optional(:VisaNumber).maybe(:string)
            optional(:SEVISID).maybe(:string)
          end
        end
      end
    end
  end
end