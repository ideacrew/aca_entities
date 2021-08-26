# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class PersonSsnIdentification
              include HappyMapper
              register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

              tag 'PersonSSNIdentification'
              namespace 'nc'

              element :IdentificationID, String, tag: 'IdentificationID', namespace: 'nc'

              def self.domain_to_mapper(person)
                mapper = self.new
                mapper.IdentificationID = person.IdentificationID

                mapper
              end
            end
          end
        end
      end
    end
  end
end
