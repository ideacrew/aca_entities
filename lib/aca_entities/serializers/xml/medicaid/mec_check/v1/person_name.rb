# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module MecCheck
          module V1
            # Happymapper implementation for the root object of a PersonName.
            class PersonName
              include HappyMapper
              register_namespace 'v11', 'http://xmlns.dc.gov/dcas/common/CommonNative/xsd/V1'

              tag 'PersonName'
              namespace 'v1'

              element :first_name, String, tag: "FirstName", namespace: "v11"
              element :middle_name, String, tag: "MiddleName", namespace: "v11"
              element :last_name, String, tag: "LastName", namespace: "v11"
              element :name_suffix, String, tag: "NameSuffix", namespace: "v11"

              def self.domain_to_mapper(person_name)
                mapper = self.new
                mapper.first_name = person_name[:first_name]
                mapper.middle_name = person_name[:middle_name]
                mapper.last_name = person_name[:last_name]
                mapper.name_suffix = person_name[:name_suffix]
                mapper
              end

              def to_hash
                {
                  first_name: first_name,
                  middle_name: middle_name,
                  last_name: last_name,
                  name_suffix: name_suffix
                }
              end
            end
          end
        end
      end
    end
  end
end