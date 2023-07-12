# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build VlpDocument hash so that transformer can deal with array values
      class VlpDocumentHashBuilder
        def call(document)
          person_ids_hash = document[:document_person_ids].each_with_object({}) do |person_id, ids_hash|
            category_text_key = person_id[:identification_category_text]
            # may need to be revisited if category text contains hyphens or other special characters
            category_text_key = category_text_key&.split&.join("_")&.downcase&.to_sym
            ids_hash[category_text_key] = person_id[:identification_id]
          end

          # may need to be revisited if category code contains hyphens or other special characters
          category_code_key = document[:category_code]&.split&.join("_")&.downcase&.to_sym
          # assuming only one document_number is sent and matches the document category code, may need to be revisited
          document_number_hash = { category_code_key => document[:document_numbers]&.first&.dig(:identification_id) }

          extracted_information_hash = person_ids_hash.merge!(document_number_hash)
          document.merge!(extracted_information_hash)
        end
      end
    end
  end
end
