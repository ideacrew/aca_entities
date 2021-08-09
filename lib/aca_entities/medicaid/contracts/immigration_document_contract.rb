# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ImmigrationDocument.
      class ImmigrationDocumentContract < Dry::Validation::Contract

        params do
          optional(:expiration_date).maybe(:hash)
          optional(:document_numbers).maybe(:array)
          optional(:document_person_ids).maybe(:array)
          optional(:same_name_indicator).maybe(:bool)
          optional(:category_text).maybe(:string)
          optional(:category_code).maybe(:string)
        end
      end
    end
  end
end
