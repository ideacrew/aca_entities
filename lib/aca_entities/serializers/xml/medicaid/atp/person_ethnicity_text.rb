# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class PersonEthnicityText
            include HappyMapper

            tag 'PersonEthnicityText'
            namespace 'nc'

            content :value, String

            def self.domain_to_mapper(ethnicity)
              mapper = self.new
              mapper.value = ethnicity.value
              mapper
            end

            def to_hash
              {
                value: value
              }
            end
          end
        end
      end
    end
  end
end