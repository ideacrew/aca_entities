# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Layout/LineLength

# TODO: Pending
# livedInUs5yearIndicator - mapping not found
# noAlienNumberIndicator - mapping not found
# lawfulPresenceGrantDate - mapping not found
# How to handle members without citizenship data
# Check for other citizenship mapping, lawful_permanent_resident, non_native_not_lawfully_present_in_us etc.
module AcaEntities
  module Functions
    # hash methods
    class Hash
      def contains_pair?(key, value)
        key?(key) && self[key] == value
      end

      def attempt_match(str)
        keys.find { |_k| key(str) }
      end
    end

    # BuildLawfulPresenceDetermination
    class BuildLawfulPresenceDetermination
      extend Dry::Transformer::Registry
      import Dry::Transformer::Coercions

      MAPPING = { 'naturalizedCitizenIndicator' => 'naturalized_citizen',
                  'citizenshipIndicator' => 'us_citizen',
                  'noAlienNumberIndicator' => 'alien_lawfully_present' }.freeze

      # NATURALIZED_CITIZEN_STATUS = 'naturalized_citizen'
      # INDIAN_TRIBE_MEMBER_STATUS = 'indian_tribe_member'
      # US_CITIZEN_STATUS = 'us_citizen'
      # NOT_LAWFULLY_PRESENT_STATUS = 'not_lawfully_present_in_us'
      # ALIEN_LAWFULLY_PRESENT_STATUS = 'alien_lawfully_present'
      # INELIGIBLE_CITIZEN_VERIFICATION = %w[not_lawfully_present_in_us non_native_not_lawfully_present_in_us].freeze

      # CITIZEN_STATUS_KINDS = %w(
      # us_citizen
      # naturalized_citizen

      # alien_lawfully_present
      # lawful_permanent_resident
      # undocumented_immigrant

      # not_lawfully_present_in_us
      # non_native_not_lawfully_present_in_us
      # ssn_pass_citizenship_fails_with_SSA
      # non_native_citizen
      # )

      def call(input, m_identifier = nil)
        member = input.find(/attestations.members.(\w+)$/)&.map(&:item)&.last
        member_identifier = m_identifier || member

        no_alien_number_indicator = input.find(Regexp.new("noAlienNumberIndicator.#{member_identifier}"))&.first
        citizenship_indicator = input.find(Regexp.new("citizenshipIndicator.#{member_identifier}"))&.first
        naturalized_citizen_indicator = input.find(Regexp.new("naturalizedCitizenIndicator.#{member_identifier}"))&.first
        lawful_presence_indicator = input.find(Regexp.new("lawfulPresenceStatusIndicator.#{member_identifier}"))&.first
        lawful_presence_documentation = input.find(
          Regexp.new("attestations.members.#{member_identifier}.lawfulPresence.lawfulPresenceDocumentation")
        )&.first

        # TODO: noAlienNumberIndicator && livedInUs5yearIndicator not used
        # lived_in_us_5_year_indicator = input.find(Regexp.new("livedInUs5yearIndicator.#{member_identifier}"))&.first

        hash = {
          no_alien_number_indicator&.name&.split('.')&.first => no_alien_number_indicator&.item,
          citizenship_indicator&.name&.split('.')&.first => citizenship_indicator&.item,
          naturalized_citizen_indicator&.name&.split('.')&.first => naturalized_citizen_indicator&.item,
          lawful_presence_indicator&.name&.split('.')&.first => lawful_presence_indicator&.item,
          lawful_presence_documentation&.name&.split('.')&.first => lawful_presence_documentation&.item
        }

        # val = hash.keys.find { |_k| hash.key(true) }
        # assign_citizen_status(val)

        if hash["citizenshipIndicator"] == true && hash["naturalizedCitizenIndicator"] == true
          "naturalized_citizen"
        elsif hash["citizenshipIndicator"] == true && hash["naturalizedCitizenIndicator"] == false
          "us_citizen"
        elsif hash["lawfulPresenceStatusIndicator"] == false
          "not_lawfully_present_in_us"
        elsif hash["lawfulPresenceStatusIndicator"] == true
          "alien_lawfully_present"
        end
      end

      def assign_citizen_status(status)
        MAPPING[status]
      end
    end
  end
end

# lawfule presence uniq keys

# "noAlienNumberIndicator",
# "citizenshipIndicator",
# "naturalizedCitizenIndicator",
# "lawfulPresenceStatusIndicator",
# "livedInUs5yearIndicator",
# "lawfulPresenceDocumentation",  # hash
# "lawfulPresenceGrantDate"

# "noAlienNumberIndicator"
# "citizenshipIndicator"
# "naturalizedCitizenIndicator"
# "lawfulPresenceStatusIndicator"
# "livedInUs5yearIndicator"
# "lawfulPresenceDocumentation"
# "PERMANENT_RESIDENT_CARD_I_551"
# "alienNumber"
# "cardNumber"
# "noIdentifiersProvidedIndicator"
# "CERTIFICATE_OF_NATURALIZATION"
# "CERTIFICATE_OF_CITIZENSHIP"
# "citizenshipNumber"
# "naturalizationCertificateNumber"
# "documentExpirationDate"
# "documentAlternateName"
# "firstName"
# "middleName"
# "lastName"
# "EMPLOYMENT_AUTHORIZATION_CARD_I_766"
# "employmentAuthorizationCategoryIdentifier"
# "NOTICE_OF_ACTION_I_797"
# "ARRIVAL_DEPARTURE_RECORD_IN_FOREIGN_PASSPORT_I_94"
# "i94Number"
# "REFUGEE_TRAVEL_DOCUMENT"
# "OTHER"
# "otherTypeText"
# "otherDocumentTypeText"
# "DOCUMENT_INDICATING_WITHHOLDING_OF_REMOVAL"
# "lawfulPresenceGrantDate"
# "MACHINE_READABLE_IMMIGRANT_VISA_WITH_TEMPORARY_I_551_LANGUAGE"
# "TEMPORARY_I_551_STAMP_ON_PASSPORT_OR_I_94_I_94A"
# "passportNumber"
# "passportIssuingCountry"
# "ARRIVAL_DEPARTURE_RECORD_IN_UNEXPIRED_FOREIGN_PASSPORT_I_94"
# "FOREIGN_PASSPORT"
# "REENTRY_PERMIT"
# "CERTIFICATE_OF_ELIGIBILITY_FOR_NONIMMIGRANT_STUDENT_STATUS_I_20"
# "sevisId"
# "CERTIFICATE_OF_ELIGIBILITY_FOR_EXCHANGE_VISITOR_STATUS_DS_2019"
# "VAWA_SELF_PETITIONER"
# "NS1_MEMBERS_OF_A_FEDERALLY_RECOGNIZED_INDIAN_TRIBE"

# citizen criteria with out "livedInUs5yearIndicator","noAlienNumberIndicator","lawfulPresenceGrantDate"

# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true, "lawfulPresenceStatusIndicator"=>true}
# {"citizenshipIndicator"=>true, "lawfulPresenceDocumentation"=>true, "naturalizedCitizenIndicator"=>true}
# {"citizenshipIndicator"=>true, "lawfulPresenceDocumentation"=>true, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceStatusIndicator"=>true}
# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true}
# {"citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true,
# "lawfulPresenceStatusIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceDocumentation"=>true}
# {"citizenshipIndicator"=>false, "lawfulPresenceStatusIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceStatusIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"citizenshipIndicator"=>true, "lawfulPresenceStatusIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceStatusIndicator"=>false, "naturalizedCitizenIndicator"=>false}

# citizen cases

# {"noAlienNumberIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"noAlienNumberIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true, "lawfulPresenceDocumentation"=>true}
# {"noAlienNumberIndicator"=>true, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"noAlienNumberIndicator"=>true}
# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"noAlienNumberIndicator"=>true, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false}
# {"citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"noAlienNumberIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"noAlienNumberIndicator"=>true, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true}
# {"livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceDocumentation"=>true}
# {"livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"noAlienNumberIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "citizenshipIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2015-11-04", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2015-11-08", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2019-05-07", "lawfulPresenceStatusIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"citizenshipIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2003-01-12", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2010-05-23", "lawfulPresenceStatusIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>false, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "citizenshipIndicator"=>false}
# {"citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>true, "noAlienNumberIndicator"=>true, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2005-06-26", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2002-02-06", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>true, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>false, "citizenshipIndicator"=>false}
# {"livedInUs5yearIndicator"=>false, "noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2016-03-31", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2009-09-12", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"livedInUs5yearIndicator"=>true, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"noAlienNumberIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>true, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2017-12-12", "lawfulPresenceStatusIndicator"=>true, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceStatusIndicator"=>false, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>true, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceStatusIndicator"=>false, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2019-05-15", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"citizenshipIndicator"=>false, "naturalizedCitizenIndicator"=>false}
# {"lawfulPresenceGrantDate"=>"2017-11-24", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}
# {"lawfulPresenceGrantDate"=>"2018-06-13", "lawfulPresenceStatusIndicator"=>true, "livedInUs5yearIndicator"=>false, "citizenshipIndicator"=>false, "lawfulPresenceDocumentation"=>true}

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Layout/LineLength