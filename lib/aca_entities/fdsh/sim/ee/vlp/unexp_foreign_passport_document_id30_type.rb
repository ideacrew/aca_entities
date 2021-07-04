# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp UnexpForeignPassportDocumentID30Type
          class UnexpForeignPassportDocumentID30Type < Dry::Struct

            attribute :i94Number,           Types::Strict::String.meta(omittable: true)
            attribute :passportNumber,      Types::Strict::String.meta(omittable: false)
            attribute :countryOfIssuance,   Types::Strict::String.meta(omittable: false)
            attribute :sevisid,             Types::Strict::String.meta(omittable: true)
            attribute :docExpirationDate,   Types::Strict::Date.meta(omittable: false)
          end
        end
      end
    end
  end
end