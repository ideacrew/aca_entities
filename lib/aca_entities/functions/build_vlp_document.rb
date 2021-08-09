# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

module AcaEntities

  module Functions
  class BuildVlpDocument
      extend Dry::Transformer::Registry
      import Dry::Transformer::Coercions

      # PERMANENT_RESIDENT_CARD_I_551
      # CERTIFICATE_OF_NATURALIZATION
      # CERTIFICATE_OF_CITIZENSHIP
      # EMPLOYMENT_AUTHORIZATION_CARD_I_766
      # NOTICE_OF_ACTION_I_797
      # ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94
      # REFUGEE_TRAVEL_DOCUMENT
      # OTHER
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

      # alienNumber
      # cardNumber
      # noIdentifiersProvidedIndicator
      # citizenshipNumber
      # naturalizationCertificateNumber
      # documentExpirationDate
      # documentAlternateName
      # employmentAuthorizationCategoryIdentifier
      # i94Number
      # otherTypeText
      # otherDocumentTypeText
      # passportNumber
      # passportIssuingCountry
      # sevisId

      VLPMAPPING = { 'naturalizationCertificateNumber' => 'naturalization_number',
                     'alienNumber' => 'alien_number',
                     'cardNumber' => 'card_number',

                     'noIdentifiersProvidedIndicator' => '',

                     'citizenshipNumber' => 'citizenship_number',

                     'documentExpirationDate' => '',
                     'documentAlternateName' => '',

                     'employmentAuthorizationCategoryIdentifier'=>'',
                     'i94Number'=>'i94_number',

                     'otherTypeText'=>'',
                     'otherDocumentTypeText'=>'',

                     'passportNumber'=>'passport_number',
                     'passportIssuingCountry'=>'country_of_citizenship',
                     'sevisId'=>'sevis_id',
      }.freeze

      def call(input, m_identifier = nil)
        member = input.find(/attestations.members.(\w+)$/)&.map(&:item)&.last
        member_identifier = m_identifier || member

        lawfulPresenceDocumentation = input.find(Regexp.new("attestations.members.#{member_identifier}.lawfulPresence.lawfulPresenceDocumentation"))&.first&.item
        @hash = {}
        # binding.pry
        if lawfulPresenceDocumentation != nil
          lawfulPresenceDocumentation.values.first.each_with_object([]) do |(key, value), output|
            if VLPMAPPING[key.to_s] != ""
              @hash[VLPMAPPING[key.to_s]] = value
              output << @hash
            end
          end
        else
          []
        end
      end
    end
  end
end

