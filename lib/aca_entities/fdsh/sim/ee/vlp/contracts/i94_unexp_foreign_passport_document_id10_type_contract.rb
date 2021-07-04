# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I94UnexpForeignPassportDocumentID10Type
          class I94UnexpForeignPassportDocumentID10TypeContract < Dry::Validation::Contract
            params do
              required(:i94Number).filled(:string)
              required(:passportNumber).filled(:string)
              required(:countryOfIssuance).filled(:string)
              required(:docExpirationDate).filled(:date)
              optional(:visaNumber).maybe(:string)
              optional(:sevisid).maybe(:string)
            end
          end
        end
      end
    end
  end
end