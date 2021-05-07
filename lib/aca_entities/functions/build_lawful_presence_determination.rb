# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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

      def call(input, m_identifier = nil)
        member = input.find(/attestations.members.(\w+)$/)&.map(&:item)&.last
        member_identifier = m_identifier || member

        no_alien_number_indicator = input.find(Regexp.new("noAlienNumberIndicator.#{member_identifier}"))&.first
        citizenship_indicator = input.find(Regexp.new("citizenshipIndicator.#{member_identifier}"))&.first
        naturalized_citizen_indicator = input.find(Regexp.new("naturalizedCitizenIndicator.#{member_identifier}"))&.first

        hash = {
          no_alien_number_indicator&.name&.split('.')&.first => no_alien_number_indicator.item,
          citizenship_indicator&.name&.split('.')&.first => citizenship_indicator.item,
          naturalized_citizen_indicator&.name&.split('.')&.first => naturalized_citizen_indicator.item
        }

        val = hash.keys.find { |_k| hash.key(true) }
        assign_citizen_status(val)
      end

      def assign_citizen_status(status)
        MAPPING[status]
      end
    end
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity