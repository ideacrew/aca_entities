# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Supplements a Person with tribal information.
          class TribalAugmentation
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'TribalAugmentation'
            namespace 'hix-core'

            # True if a person is a member of a recognized tribe; false otherwise.
            element :recognized_tribe_indicator, Boolean, tag: 'PersonRecognizedTribeIndicator'

            # True if the person is an American Indian or Alaska Native by race or ethnicity; false otherwise.
            element :american_indian_or_alaska_native_indicator, Boolean, tag: 'PersonAmericanIndianOrAlaskaNativeIndicator'

            # A name of a native tribe.
            element :person_tribe_name, String, tag: 'PersonTribeName'

            # A state, commonwealth, province, or other such geopolitical subdivision of a country.
            element :location_state_us_postal_service_code, String, tag: 'LocationStateUSPostalServiceCode', namespace: 'nc'

            def self.domain_to_mapper(_tribal_augmentation)
              self.new
            end
          end
        end
      end
    end
  end
end