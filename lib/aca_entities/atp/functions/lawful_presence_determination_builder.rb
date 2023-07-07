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
          person_augmentation = cache.find(Regexp.new("record.people.#{member_id}.augementation"))
          us_citizen_indicator = cache.find(Regexp.new("us_citizen_indicator.#{member_id}"))&.first&.item
          naturalized_indicator = person_augmentation.map(&:item).first[:us_naturalized_citizen_indicator]
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
