# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp UnexpForeignPassportDocumentID30Type
          class UnexpForeignPassportDocumentID30TypeContract < Dry::Validation::Contract
            params do
              required(:passportNumber).filled(:string)
              required(:countryOfIssuance).filled(:string)
              required(:docDescReq).filled(:string)
              required(:docExpirationDate).filled(:date)
              optional(:sevisid).maybe(:string)
            end
          end
        end
      end
    end
  end
end