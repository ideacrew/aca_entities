# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ImmigrationDocument.
      class ImmigrationDocumentContract < Dry::Validation::Contract

        params do
          optional(:expiration_date).maybe(:date)
          optional(:document_number).maybe(:string)
          optional(:document_type_code).maybe(Types::ImmigrationDocumentTypeCode)
          optional(:document_type_other_code).maybe(:string)
          optional(:name_of_other_document).maybe(:string)
        end
      end
    end
  end
end
