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
          add_key 'i94_number', value: nil
          add_key 'visa_number', value: nil
          add_key 'sevis_id', value: nil
          # category code does not get sent with spaces, so no underscore for key
          map 'naturalizationcertificate', 'naturalization_number'
          add_key 'passport_number', value: nil
          add_key 'receipt_number', value: nil
          add_key 'citizenship_number', value: nil
          add_key 'card_number', value: nil
          add_key 'country_of_citizenship', value: nil
          add_key 'expiration_date', value: nil
          add_key 'issuing_country', value: nil
          add_key 'description', value: nil
          add_key 'incomes', value: nil

        end
      end
    end
  end
end