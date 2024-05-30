# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
            # Happymapper implementation for the root object of an Request.
              class Applicant
                include HappyMapper

                tag 'Applicant'

                element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification'
                has_one :PersonName, PersonName
                has_one :PersonBirthDate, PersonBirthDate
                element :PersonSexCode, String, tag: 'PersonSexCode'

                def self.domain_to_mapper(applicant)
                  mapper = self.new
                  mapper.PersonSSNIdentification = applicant.PersonSSNIdentification
                  mapper.PersonName = PersonName.domain_to_mapper(applicant.PersonName)
                  mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(applicant.PersonBirthDate)
                  mapper.PersonSexCode = applicant.PersonSexCode

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
