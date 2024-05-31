# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
              # Applicant class
              #
              # @!attribute [rw] PersonSSNIdentification
              #   @return [String] the person's SSN
              # @!attribute [rw] PersonName
              #   @return [PersonName] the person's name
              # @!attribute [rw] PersonBirthDate
              #   @return [PersonBirthDate] the person's birth date
              # @!attribute [rw] PersonSexCode
              #   @return [String] the person's sex code
              class Applicant
                include HappyMapper

                # XML tag for Applicant
                tag 'Applicant'

                # XML mapping rule for PersonSSNIdentification
                # @return [String]
                element :PersonSSNIdentification, String, tag: 'PersonSSNIdentification'

                # XML mapping rule for PersonName
                # @return [PersonName]
                has_one :PersonName, PersonName

                # XML mapping rule for PersonBirthDate
                # @return [PersonBirthDate]
                has_one :PersonBirthDate, PersonBirthDate

                # XML mapping rule for PersonSexCode
                # @return [String]
                element :PersonSexCode, String, tag: 'PersonSexCode'

                # This method maps domain objects to mapper objects
                #
                # @param applicant [Object] the domain object
                # @return [Applicant] the mapper object
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