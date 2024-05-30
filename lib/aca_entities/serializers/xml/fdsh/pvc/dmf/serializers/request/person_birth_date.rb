# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
            # Include XML element and type definitions.
              class PersonBirthDate
                include HappyMapper

                tag 'PersonBirthDate'

                element :date, String, tag: "Date"

                def self.domain_to_mapper(person_birth_date)
                  mapper = self.new
                  mapper.date = person_birth_date.strftime
                  mapper
                end
              end
            end
          end
        end
      end
    end
  end
end
