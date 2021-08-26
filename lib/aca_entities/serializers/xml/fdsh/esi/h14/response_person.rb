# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Esi
          module H14
            # Happymapper implementation for the root object of an Request.
            class ResponsePerson
              include HappyMapper
              register_namespace 'ext', 'http://vesim.dsh.cms.gov/extension/1.0'

              tag 'ResponsePerson'
              namespace 'ext'

              has_one :PersonSSNIdentification, PersonSsnIdentification

              def self.domain_to_mapper(person)
                mapper = self.new
                mapper.PersonSSNIdentification = PersonSsnIdentification.domain_to_mapper(person.PersonSSNIdentification)

                mapper
              end
            end
          end
        end
      end
    end
  end
end
