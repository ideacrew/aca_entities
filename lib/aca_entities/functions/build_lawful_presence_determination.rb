# frozen_string_literal: true

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

      def call(input)
        hash = { input.resolve('noAlienNumberIndicator').name => input.resolve('noAlienNumberIndicator').item,
                 input.resolve('citizenshipIndicator').name => input.resolve('citizenshipIndicator').item,
                 input.resolve('naturalizedCitizenIndicator').name => input.resolve('naturalizedCitizenIndicator').item }

        val = hash.keys.find { |_k| hash.key(true) }
        assign_citizen_status(val)
      end

      def assign_citizen_status(status)
        MAPPING[status]
      end
    end
  end
end
