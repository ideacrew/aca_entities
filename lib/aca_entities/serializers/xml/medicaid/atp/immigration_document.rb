# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An immigration document used in determining lawful presence status.
          class ImmigrationDocument
            include HappyMapper

            tag 'LawfulPresenceStatusImmigrationDocument'
            namespace 'hix-ee'

            has_one :expiration_date, DocumentExpirationDate
            has_many :document_numbers, DocumentNumber
            has_many :document_person_ids, DocumentPersonIdentification

            # True if an immigration document is issued in the same name as the person presenting it as proof of lawful presence;
            element :same_name_indicator, Boolean, tag: 'LawfulPresenceDocumentSameNameIndicator'

            # A description of a kind of immigration document.
            element :category_text, String, tag: 'LawfulPresenceDocumentCategoryText'

            # A code for a kind of immigration document
            element :category_code, String, tag: 'LawfulPresenceDocumentCategoryCode'

            def self.domain_to_mapper(document)
              mapper = self.new
              mapper.same_name_indicator = document.same_name_indicator
              mapper.category_text = document.category_text
              mapper.category_code = document.category_code
              mapper.expiration_date = DocumentExpirationDate.domain_to_mapper(document.expiration_date)
              mapper.document_numbers = document.document_numbers&.map { |num| DocumentNumber.domain_to_mapper(num) }
              mapper.document_person_ids = document.document_person_ids&.map { |dpi| DocumentPersonIdentification.domain_to_mapper(dpi) }
              mapper
            end

            def to_hash
              {
                same_name_indicator: same_name_indicator,
                category_text: category_text,
                category_code: category_code,
                expiration_date: expiration_date&.to_hash,
                document_numbers: document_numbers.map(&:to_hash),
                document_person_ids: document_person_ids.map(&:to_hash)
              }
            end
          end
        end
      end
    end
  end
end