# frozen_string_literal: true

# rubocop:disable Layout/LineLengthLayout/LineLength
module AcaEntities
  module Ffe
    module Transformers
      module Cv
        # vlp document transformer
        class VlpDocument < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          #   VLPMAPPING = {
          #                  'noIdentifiersProvidedIndicator' => '',
          #                  'documentAlternateName' => '',
          #                  'employmentAuthorizationCategoryIdentifier' => '',
          #                  'otherTypeText' => '',
          #                  'otherDocumentTypeText' => '' }.freeze

          DocumentMapping = {
            "REENTRY_PERMIT" => "I-327 (Reentry Permit)",
            "PERMANENT_RESIDENT_CARD_I_551" => "I-551 (Permanent Resident Card)",
            "REFUGEE_TRAVEL_DOCUMENT" => "I-571 (Refugee Travel Document)",
            "EMPLOYMENT_AUTHORIZATION_CARD_I_766" => "I-766 (Employment Authorization Card)",
            "CERTIFICATE_OF_CITIZENSHIP" => "Certificate of Citizenship",
            "CERTIFICATE_OF_NATURALIZATION" => "Naturalization Certificate",
            "MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE" => "Machine Readable Immigrant Visa (with Temporary I-551 Language)",
            "TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A" => "Temporary I-551 Stamp (on passport or I-94)",
            "ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94" => "I-94 (Arrival/Departure Record)",
            "ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94" => "I-94 (Arrival/Departure Record) in Unexpired Foreign Passport",
            # "" => "Unexpired Foreign Passport",
            "CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20" => "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)",
            "CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019" => "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)"
            # "" => "Other (With Alien Number)",
            # "" => "Other (With I-94 Number)"
          }.freeze

          #---vlp_document_kind_options---
          # NOTICE_OF_ACTION_I_797
          # DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL
          # FOREIGN_PASSPORT
          # VAWA_SELF_PETITIONER
          # NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE

          #---fields---
          # noIdentifiersProvidedIndicator
          # documentAlternateName
          # employmentAuthorizationCategoryIdentifier
          # otherTypeText
          # otherDocumentTypeText

          map 'subject', 'subject', function: ->(v) {DocumentMapping[v]}
          map 'citizenshipNumber', "citizenship_number"
          map 'alienNumber', 'alien_number'
          map 'i94Number', 'i94_number'
          #  map '', 'visa_number'
          map 'passportNumber', 'passport_number'
          map 'sevisId', 'sevis_id'
          map 'naturalizationCertificateNumber', 'naturalization_number'
          #  map '', 'receipt_number'
          map 'cardNumber', 'card_number'
          #  map '', 'country_of_citizenship'
          map 'documentExpirationDate', 'expiration_date'
          map 'passportIssuingCountry', 'issuing_country'
          #   map 'employmentAuthorizationCategoryIdentifier'
          add_key 'creator', value: 'dchl'
          add_key 'publisher', value: 'dchl'
          add_key 'source', value: 'enroll_system'
          add_key 'language', value: 'en'

        end
      end
    end
  end
end
# rubocop:enable Layout/LineLengthLayout/LineLength