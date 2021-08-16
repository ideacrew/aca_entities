# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Aces
        # Transformers implementation for atp payloads
        class VlpDocument < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          add_key 'category_text'
          add_key 'document_person_ids'
          map 'vlp_subject', 'category_code'
          map 'alien_number', 'document_numbers.identification_id'
          map 'i94_number', 'document_numbers.identification_id'
          map 'visa_number', 'document_numbers.identification_id'
          map 'passport_number', 'document_numbers.identification_id'
          map 'sevis_number', 'document_numbers.identification_id'
          map 'naturalization_number', 'document_numbers.identification_id'
          map 'receipt_number', 'document_numbers.identification_id'
          map 'citizenship_number', 'document_numbers.identification_id'
          map 'card_number', 'document_numbers.identification_id'
          map 'country_of_citizenship', 'document_numbers.identification_jurisdiction'
          map 'issuing_country', 'document_numbers.identification_jurisdiction'
          map 'expiration_date', 'expiration_date.date'
        end
      end
    end
  end
end