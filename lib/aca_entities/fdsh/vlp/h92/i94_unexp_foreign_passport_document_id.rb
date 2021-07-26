# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp I94UnexpForeignPassportDocumentId
        class I94UnexpForeignPassportDocumentId < Dry::Struct

          attribute :I94Number,           Types::Strict::String.meta(omittable: false)
          attribute :VisaNumber,          Types::String.optional.meta(omittable: true)
          attribute :PassportNumber,      Types::Strict::String.meta(omittable: false)
          attribute :CountryOfIssuance,   Types::Strict::String.meta(omittable: false)
          attribute :SEVISID,             Types::String.optional.meta(omittable: true)
          attribute :DocExpirationDate,   Types::Strict::Date.meta(omittable: false)
        end
      end
    end
  end
end