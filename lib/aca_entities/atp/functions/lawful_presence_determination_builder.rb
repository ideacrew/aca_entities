# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions

      # build LawfulPresenceDetermination attributes
      class LawfulPresenceDeterminationBuilder
        extend Dry::Transformer::Registry
        import Dry::Transformer::Coercions

        # rubocop:disable Metrics/CyclomaticComplexity
        def call(cache, m_identifier = nil)
          member_id = m_identifier || '*'
          person_augmentation = cache.find(Regexp.new("record.people.#{member_id}.augementation"))
          us_citizen_indicator = cache.find(Regexp.new("us_citizen_indicator.#{member_id}"))&.first&.item
          naturalized_indicator = person_augmentation.map(&:item).first[:us_naturalized_citizen_indicator]

          # if an immigration document exists, then the person is lawfully present
          applicants = cache.find(Regexp.new("insurance_application.insurance_applicants"))&.first&.item
          insurance_applicant = applicants[member_id.to_sym]
          immigration_document = insurance_applicant&.dig(:lawful_presence_status, :immigration_documents, 0)
          alien_lawfully_present_indicator = immigration_document&.dig(:category_code)&.present?

          hash = {
            'us_citizen' => us_citizen_indicator,
            'naturalized_citizen' => naturalized_indicator,
            'alien_lawfully_present' => alien_lawfully_present_indicator
          }

          val = if naturalized_indicator
                  'naturalized_citizen'
                else
                  hash.keys.find { |k| hash[k] == true }
                end
          val || 'not_lawfully_present_in_us'
        end
        # rubocop:enable Metrics/CyclomaticComplexity
      end
    end
  end
end
