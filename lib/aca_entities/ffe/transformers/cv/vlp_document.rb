# frozen_string_literal: true

# rubocop:disable Layout/LineLengthLayout/LineLength
# TODO : Pending
#  documentAlternateName - no mapping found
#  employmentAuthorizationCategoryIdentifier - no mapping found
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

          # uniq MCR vlp subjects:
          # PERMANENT_RESIDENT_CARD_I_551
          # CERTIFICATE_OF_NATURALIZATION
          # CERTIFICATE_OF_CITIZENSHIP
          # EMPLOYMENT_AUTHORIZATION_CARD_I_766
          # NOTICE_OF_ACTION_I_797
          # ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94
          # REFUGEE_TRAVEL_DOCUMENT
          # OTHER --
          # DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL
          # MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE
          # TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A
          # ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94
          # FOREIGN_PASSPORT
          # REENTRY_PERMIT
          # CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20
          # CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019
          # VAWA_SELF_PETITIONER
          # NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE

          # "alienNumber"
          # "cardNumber"
          # "noIdentifiersProvidedIndicator"
          # "citizenshipNumber"
          # "naturalizationCertificateNumber"
          # "documentExpirationDate"
          # "documentAlternateName"
          # "employmentAuthorizationCategoryIdentifier"
          # "i94Number"
          # "otherTypeText"
          # "otherDocumentTypeText"
          # "passportNumber"
          # "passportIssuingCountry"
          # "sevisId"

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
            "FOREIGN_PASSPORT" => "Unexpired Foreign Passport",
            "CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20" => "I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)",
            "CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019" => "DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)",
            "NOTICE_OF_ACTION_I_797_WITH_ALIEN" => "Other (With Alien Number)",
            "NOTICE_OF_ACTION_I_797_I_94" => "Other (With I-94 Number)",
            "OTHER_WITH_ALIEN" => "Other (With Alien Number)",
            "OTHER_WITH_I_94" => "Other (With I-94 Number)"
          }.freeze

          #---missed subject mappig vlp_document_kind_options---
          # DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL  -- only 2 instance with no data can be ignored
          # VAWA_SELF_PETITIONER  -- only 1 instance with no data can be ignored
          # NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE -- only 1 instance with no data can be ignored

          #---missed mapping fields---
          # noIdentifiersProvidedIndicator  # no mapping needed to this
          # documentAlternateName -- ??
          # otherTypeText  - mapped to description
          # employmentAuthorizationCategoryIdentifier

          map 'subject', 'subject', function: ->(v) { DocumentMapping[v] }
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
          map 'otherDocumentTypeText', 'description'
          add_key 'creator', value: 'dchl'
          add_key 'publisher', value: 'dchl'
          add_key 'source', value: 'enroll_system'
          add_key 'language', value: 'en'

        end
      end
    end
  end
end

# PERMANENT_RESIDENT_CARD_I_551
# alienNumber
# cardNumber
# noIdentifiersProvidedIndicator
# CERTIFICATE_OF_NATURALIZATION
# CERTIFICATE_OF_CITIZENSHIP
# citizenshipNumber
# naturalizationCertificateNumber
# documentExpirationDate
# documentAlternateName
# firstName
# middleName
# lastName
# EMPLOYMENT_AUTHORIZATION_CARD_I_766
# employmentAuthorizationCategoryIdentifier
# NOTICE_OF_ACTION_I_797
# ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94
# i94Number
# REFUGEE_TRAVEL_DOCUMENT
# OTHER
# otherTypeText
# otherDocumentTypeText
# DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL
# MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE
# TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A
# passportNumber
# passportIssuingCountry
# ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94
# FOREIGN_PASSPORT
# REENTRY_PERMIT
# CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20
# sevisId
# CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019
# VAWA_SELF_PETITIONER
# NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE

# ["alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["noIdentifiersProvidedIndicator"]
# ["citizenshipNumber", "noIdentifiersProvidedIndicator"]
# ["naturalizationCertificateNumber", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "naturalizationCertificateNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "citizenshipNumber", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["cardNumber", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "i94Number", "noIdentifiersProvidedIndicator"]
# ["i94Number", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText"]
# ["documentExpirationDate", "employmentAuthorizationCategoryIdentifier", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "sevisId", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "employmentAuthorizationCategoryIdentifier", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["documentExpirationDate", "alienNumber", "passportNumber", "passportIssuingCountry", "documentAlternateName", "noIdentifiersProvidedIndicator"]
# ["sevisId", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["sevisId", "noIdentifiersProvidedIndicator"]
# ["alienNumber", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText"]
# ["i94Number", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText"]

# ["PERMANENT_RESIDENT_CARD_I_551", "alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_NATURALIZATION", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_CITIZENSHIP", "citizenshipNumber", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_NATURALIZATION", "naturalizationCertificateNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_NATURALIZATION", "alienNumber", "naturalizationCertificateNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_CITIZENSHIP", "alienNumber", "citizenshipNumber", "noIdentifiersProvidedIndicator"]
# ["NOTICE_OF_ACTION_I_797", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_CITIZENSHIP", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "alienNumber", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["PERMANENT_RESIDENT_CARD_I_551", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["PERMANENT_RESIDENT_CARD_I_551", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94", "documentExpirationDate", "i94Number", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["REFUGEE_TRAVEL_DOCUMENT", "noIdentifiersProvidedIndicator"]
# ["ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94", "i94Number", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "noIdentifiersProvidedIndicator"]
# ["ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_CITIZENSHIP", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["OTHER", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText", "firstName", "middleName", "lastName"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL", "EMPLOYMENT_AUTHORIZATION_CARD_I_766", "noIdentifiersProvidedIndicator", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_NATURALIZATION", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "employmentAuthorizationCategoryIdentifier", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["NOTICE_OF_ACTION_I_797", "i94Number", "noIdentifiersProvidedIndicator"]
# ["MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentExpirationDate", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A", "documentExpirationDate", "alienNumber", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["OTHER", "alienNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText", "firstName", "lastName"]
# ["OTHER", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94", "noIdentifiersProvidedIndicator"]
# ["FOREIGN_PASSPORT", "documentExpirationDate", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A", "documentExpirationDate", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["REENTRY_PERMIT", "documentExpirationDate", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20", "documentExpirationDate", "sevisId", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "employmentAuthorizationCategoryIdentifier", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["FOREIGN_PASSPORT", "noIdentifiersProvidedIndicator"]
# ["MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE", "alienNumber", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["NOTICE_OF_ACTION_I_797", "noIdentifiersProvidedIndicator"]
# ["PERMANENT_RESIDENT_CARD_I_551", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE", "documentExpirationDate", "alienNumber", "passportNumber", "passportIssuingCountry", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "lastName"]
# ["OTHER", "i94Number", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20", "sevisId", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["OTHER", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20", "sevisId", "noIdentifiersProvidedIndicator"]
# ["OTHER", "alienNumber", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "alienNumber", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["OTHER", "i94Number", "noIdentifiersProvidedIndicator", "otherTypeText", "otherDocumentTypeText"]
# ["CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20", "documentExpirationDate", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019", "documentExpirationDate", "sevisId", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]
# ["EMPLOYMENT_AUTHORIZATION_CARD_I_766", "documentExpirationDate", "cardNumber", "documentAlternateName", "noIdentifiersProvidedIndicator", "firstName", "middleName", "lastName"]
# ["VAWA_SELF_PETITIONER", "PERMANENT_RESIDENT_CARD_I_551", "noIdentifiersProvidedIndicator", "documentExpirationDate", "alienNumber", "noIdentifiersProvidedIndicator"]
# ["NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE", "EMPLOYMENT_AUTHORIZATION_CARD_I_766", "noIdentifiersProvidedIndicator", "documentExpirationDate", "alienNumber", "employmentAuthorizationCategoryIdentifier", "cardNumber", "noIdentifiersProvidedIndicator"]
# ["MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE", "documentExpirationDate", "passportNumber", "passportIssuingCountry", "noIdentifiersProvidedIndicator"]

# lawful document more than 1

# [["DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL", "EMPLOYMENT_AUTHORIZATION_CARD_I_766"],
# ["DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL", "EMPLOYMENT_AUTHORIZATION_CARD_I_766"],
# ["VAWA_SELF_PETITIONER", "PERMANENT_RESIDENT_CARD_I_551"],
# ["NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE", "EMPLOYMENT_AUTHORIZATION_CARD_I_766"]

# rubocop:enable Layout/LineLengthLayout/LineLength