# frozen_string_literal: true

module AcaEntities
  module Atp
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

      # build LawfulPresenceDetermination attributes
      class LawfulPresenceDeterminationBuilder
        extend Dry::Transformer::Registry
        import Dry::Transformer::Coercions

        MAPPING = { 'naturalizedCitizenIndicator' => 'naturalized_citizen',
                    'citizenshipIndicator' => 'us_citizen',
                    'noAlienNumberIndicator' => 'alien_lawfully_present',
                    'notLawfullyPresentInUs' => 'not_lawfully_present_in_us' }.freeze

        # NATURALIZED_CITIZEN_STATUS = 'naturalized_citizen'
        # INDIAN_TRIBE_MEMBER_STATUS = 'indian_tribe_member'
        # US_CITIZEN_STATUS = 'us_citizen'
        # NOT_LAWFULLY_PRESENT_STATUS = 'not_lawfully_present_in_us'
        # ALIEN_LAWFULLY_PRESENT_STATUS = 'alien_lawfully_present'
        # INELIGIBLE_CITIZEN_VERIFICATION = %w[not_lawfully_present_in_us non_native_not_lawfully_present_in_us].freeze

        def call(cache, _m_identifier = nil)
          us_citizen_indicator = cache.resolve(:us_citizen_indicator, identifier: true).item
          naturalized_indicator = cache.find(Regexp.new('record.people.*.augementation')).map(&:item).last[:us_naturalized_citizen_indicator]

          # member = input.find(/attestations.members.(\w+)$/)&.map(&:item)&.last
          # member_identifier = m_identifier || member

          # no_alien_number_indicator = input.find(Regexp.new("noAlienNumberIndicator.#{member_identifier}"))&.first
          # citizenship_indicator = input.find(Regexp.new("citizenshipIndicator.#{member_identifier}"))&.first
          # naturalized_citizen_indicator = input.find(Regexp.new("naturalizedCitizenIndicator.#{member_identifier}"))&.first

          hash = {
            # no_alien_number_indicator&.name&.split('.')&.first => no_alien_number_indicator&.item,
            'citizenshipIndicator' => us_citizen_indicator,
            'naturalizedCitizenIndicator' => naturalized_indicator
          }

          val = hash.keys.find { |_k| hash.key(true) }
          assign_citizen_status(val || "notLawfullyPresentInUs")
        end

        def assign_citizen_status(status)
          MAPPING[status]
        end
      end
    end
  end
end
