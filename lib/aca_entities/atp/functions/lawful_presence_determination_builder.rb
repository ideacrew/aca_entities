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

          applicants = cache.find(Regexp.new("insurance_application.insurance_applicants"))&.first&.item
          insurance_applicant = applicants[member_id.to_sym]
          alien_indicator = insurance_applicant&.dig(:lawful_presence_status, :lawful_presence_status_eligibility, :eligibility_indicator)
          alien_lawfully_present_indicator = alien_indicator&.present?
          hash = {
            'us_citizen' => us_citizen_indicator,
            'naturalized_citizen' => naturalized_indicator,
            'alien_lawfully_present' => alien_lawfully_present_indicator
          }

          lawful_status(hash, naturalized_indicator)
        end

        def lawful_status(mapping_hash, naturalized_indicator)
          val = if naturalized_indicator
                  'naturalized_citizen'
                else
                  mapping_hash.keys.find { |k| mapping_hash[k] == true }
                end
          val || 'not_lawfully_present_in_us'
        end

      end
    end
  end
end
