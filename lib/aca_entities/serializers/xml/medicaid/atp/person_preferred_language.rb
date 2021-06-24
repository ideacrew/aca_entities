# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type that supplements an nc:Person with health insurance specific information.
          class PersonPreferredLanguage
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'PersonPreferredLanguage'
            namespace 'hix-core'

            element :speaks_language_indicator, Boolean, tag: 'PersonSpeaksLanguageIndicator', namespace: "nc"
            element :writes_language_indicator, Boolean, tag: 'PersonWritesLanguageIndicator', namespace: "nc"
            has_many :language_name, String, tag: "LanguageName", namespace: "nc"

            def self.domain_to_mapper(person)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end