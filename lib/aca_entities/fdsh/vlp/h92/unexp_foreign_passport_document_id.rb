# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp UnexpForeignPassportDocumentId
        class UnexpForeignPassportDocumentId < Dry::Struct

          attribute :I94Number,           Types::String.optional.meta(omittable: true)
          attribute :PassportNumber,      Types::Strict::String.meta(omittable: false)
          attribute :CountryOfIssuance,   Types::Strict::String.meta(omittable: false)
          attribute :SEVISID,             Types::String.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Date.meta(omittable: false)
        end
      end
    end
  end
end