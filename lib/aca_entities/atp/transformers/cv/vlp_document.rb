# frozen_string_literal: true

module AcaEntities
    module Atp
      module Transformers
        module Cv
          # Transformers implementation for atp payloads
          class VlpDocument < ::AcaEntities::Operations::Transforms::Transform
            include ::AcaEntities::Operations::Transforms::Transformer

            map 'category_code', 'subject', memoize: true, visible: true
            map 'document_numbers', 'vlp_doc_numbers', memoize: true, visible: false
            map 'document_person_ids', 'vlp_doc_person_ids', memoize: true, visible: false
            add_key 'alien_number', function: lambda { |v|
                return nil unless v
                doc_person_ids = v.resolve('vlp_doc_person_ids').item
                doc_person_ids&.where({identification_category_text: 'Alien Number'})&.first&.dig(:identification_id)
            }
            add_key 'i94_number', value: nil
            add_key 'visa_number', value: nil
            add_key 'sevis_id', value: nil
            add_key 'naturalization_number', function: lambda { |v|
                binding.irb
                return nil unless v
                category_code = v.resolve('subject').item
                doc_numbers= v.resolve('vlp_doc_numbers').item
                # assumption that only one document number is sent and matches the document category code
                # schema does permit multiple document numbers, so this may need to be revisited
                return doc_numbers&.first if category_code == "NaturalizationCertificate"
            }
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

# <ns11:LawfulPresenceStatusImmigrationDocument> 
#    <ns11:LawfulPresenceDocumentNumber> 
#       <ns2:IdentificationID>123456</ns2:IdentificationID> 
#    </ns11:LawfulPresenceDocumentNumber> 
#    <ns11:LawfulPresenceDocumentPersonIdentification> 
#        <ns2:IdentificationID>123456789</ns2:IdentificationID>
#        <ns2:IdentificationCategoryText>Alien Number</ns2:IdentificationCategoryText> 
#    </ns11:LawfulPresenceDocumentPersonIdentification> 
#    <ns11:LawfulPresenceDocumentCategoryCode>NaturalizationCertificate</ns11:LawfulPresenceDocumentCategoryCode> 
# </ns11:LawfulPresenceStatusImmigrationDocument> 