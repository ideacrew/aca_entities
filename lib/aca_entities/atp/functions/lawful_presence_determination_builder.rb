# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build LawfulPresenceDetermination attributes
      class LawfulPresenceDeterminationBuilder
        extend Dry::Transformer::Registry
        import Dry::Transformer::Coercions

        def call(cache, m_identifier = nil)
          member_id = m_identifier || '*'
          #issue - grabbing the last applicant information and using it for all applicants
          us_citizen_indicator = cache.resolve(:us_citizen_indicator, identifier: true).item
          naturalized_indicator = cache.find(Regexp.new("record.people.#{member_id}.augementation")).map(&:item).last[:us_naturalized_citizen_indicator]
          binding.irb
          # no_alien_number_indicator = input.find(Regexp.new("noAlienNumberIndicator.#{member_identifier}"))&.first
          hash = {
            'us_citizen' => us_citizen_indicator,
            'naturalized_citizen' => naturalized_indicator
            # 'alien_lawfully_present' => no_alien_number_indicator,
          }

          val = if naturalized_indicator
                  'naturalized_citizen'
                else
                  hash.keys.find { |_k| hash.key(true) }
                end
          val || 'not_lawfully_present_in_us'
        end

      end
    end
  end
end
