# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type that supplements an nc:Person with health insurance specific information.
          class PersonPreferredLanguage
            include HappyMapper

            tag 'PersonPreferredLanguage'
            namespace 'hix-core'

            element :language_name, String, tag: "LanguageName", namespace: "nc"
            element :speaks_language_indicator, Boolean, tag: 'PersonSpeaksLanguageIndicator', namespace: "nc"
            element :writes_language_indicator, Boolean, tag: 'PersonWritesLanguageIndicator', namespace: "nc"

            def self.domain_to_mapper(preferred_language)
              mapper = self.new
              mapper.speaks_language_indicator = true if preferred_language&.language_name.present?
              mapper.writes_language_indicator = true if preferred_language&.language_name.present?
              mapper.language_name = preferred_language.language_name
              mapper
            end

            def to_hash
              {
                speaks_language_indicator: speaks_language_indicator,
                writes_language_indicator: writes_language_indicator,
                language_name: language_name
              }
            end
          end
        end
      end
    end
  end
end