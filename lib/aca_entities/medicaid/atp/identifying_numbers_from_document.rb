# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp IdentifyingNumbersFromDocument
      class IdentifyingNumbersFromDocument < Dry::Struct

        attribute :identifying_number,                          Types::String.optional.meta(omittable: true)
        attribute :identifying_number_type,                     Types::String.optional.meta(omittable: true)
        attribute :foreign_passport_country_of_issuance_code,   Types::String.optional.meta(omittable: true)
      end
    end
  end
end
