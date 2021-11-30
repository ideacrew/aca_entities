# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # Include XML element and type definitions.
          class Ethnicity
            include HappyMapper

            tag 'PersonEthnicityText'
            namespace 'nc'

            def self.domain_to_mapper(person_name)
              person_name
            end

            def to_hash
              {
              }
            end
          end
        end
      end
    end
  end
end