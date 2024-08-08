# frozen_string_literal: true

module AcaEntities
  module Atp
    module Transformers
      module Cv
        # Transformers implementation for atp payloads
        class VlpDocument < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer
          map 'category_code', 'subject'
          map 'alien_number', 'alien_number'
          map 'i94_number', 'i94_number'
          map 'visa_number', 'visa_number'
          map 'sevis_id', 'sevis_id'
          map 'naturalization_certificate', 'naturalization_number'
          map 'passport_number', 'passport_number'
          add_key 'receipt_number', value: nil
          map 'citizenship_number', 'citizenship_number'
          map 'card_number', 'card_number'
          map 'country_of_citizenship', 'country_of_citizenship'
          map 'expiration_date', 'expiration_date'
          add_key 'issuing_country', value: nil
        end
      end
    end
  end
end