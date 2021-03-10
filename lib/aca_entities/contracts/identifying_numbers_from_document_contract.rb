# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for IdentifyingNumbersFromDocument.
    class IdentifyingNumbersFromDocumentContract < Dry::Validation::Contract

      params do
        optional(:identifying_number).maybe(:string)
        optional(:identifying_number_type).maybe(:string)
        optional(:foreign_passport_country_of_issuance_code).maybe(Types::IsoAlpha3Code)
      end

      rule(:identifying_number) do
        if key?
          # required when Document Number is not null
          # implement this once ImmigrationDocument entities are defined
        end
      end

      rule(:identifying_number_type) do
        if key?
          # required when Document Number is not null
          # implement this once ImmigrationDocument entities are defined
        end
      end
    end
  end
end
