# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build VlpDocument hash so that transformer can deal with array values
      class VlpDocumentHashBuilder
        SUBJECT_MAP = {
          "NaturalizationCertificate" => "Naturalization Certificate",
          "CertificateOfCitizenship" => "Certificate of Citizenship",
          "DS2019" => "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)",
          "I20" => "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)",
          "I327" => "I-327 (Reentry Permit)",
          "I551" => "I-551 (Permanent Resident Card)",
          "I571" => "I-571 (Refugee Travel Document)",
          "I766" => "I-766 (Employment Authorization Card)",
          "I94" => "I-94 (Arrival/Departure Record)",
          "I94InPassport" => "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
          "MachineReadableVisa" => "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
          "TemporaryI551Stamp" => "Temporary I-551 Stamp (on passport or I-94)",
          "UnexpiredForeignPassport" => "Unexpired Foreign Passport"
        }.freeze

        def call(document)
          vlp_document = update_subject(document)
          person_ids_hash = create_person_ids_hash(vlp_document)
          document_number_hash = create_document_number_hash(vlp_document)

          extracted_information_hash = person_ids_hash.merge!(document_number_hash)
          vlp_document.merge!(extracted_information_hash)
        end

        def update_subject(document)
          subject = document[:category_code]
          document[:category_code] = SUBJECT_MAP[subject] || subject
          document
        end

        def create_person_ids_hash(vlp_document)
          vlp_document[:document_person_ids]&.each_with_object({}) do |person_id, ids_hash|
            category_text_key = person_id[:identification_category_text]
            # may need to be revisited if category text contains hyphens or other special characters
            category_text_key = category_text_key&.split&.join("_")&.downcase&.to_sym
            ids_hash[category_text_key] = person_id[:identification_id]
          end
        end

        def create_document_number_hash(vlp_document)
          # may need to be revisited if category code contains hyphens or other special characters
          category_code_key = vlp_document[:category_code]&.split&.join("_")&.downcase&.to_sym
          # assuming only one document_number is sent and matches the document category code, may need to be revisited
          { category_code_key => vlp_document[:document_numbers]&.first&.dig(:identification_id) }
        end
      end
    end
  end
end
