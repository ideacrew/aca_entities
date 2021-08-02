# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ssa
          module H3

            # Include XML element and type definitions.
            class PersonBirthDate
              include HappyMapper
              register_namespace 'ns1', 'http://niem.gov/niem/niem-core/2.0'

              tag 'PersonBirthDate'
              namespace 'ns1'

              element :Date, Date, tag: "Date", namespace: "ns1"

              def self.domain_to_mapper(person_birth_date)
                mapper = self.new
                mapper.Date = person_birth_date.Date

                mapper
              end
            end

          end
        end
      end
    end
  end
end
