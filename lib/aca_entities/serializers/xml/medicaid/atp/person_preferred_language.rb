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

            element :speaks_language_indicator, Boolean, tag: 'PersonSpeaksLanguageIndicator', namespace: "nc"
            element :writes_language_indicator, Boolean, tag: 'PersonWritesLanguageIndicator', namespace: "nc"
            element :language_name, String, tag: "LanguageName", namespace: "nc"

            def self.domain_to_mapper(_preferred_language)
              self.new
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