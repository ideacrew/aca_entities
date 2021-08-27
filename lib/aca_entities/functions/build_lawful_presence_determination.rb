# frozen_string_literal: true

require 'pry'

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize
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

        # binding.pry
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
      end

      def assign_citizen_status(status)
        MAPPING[status]
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize