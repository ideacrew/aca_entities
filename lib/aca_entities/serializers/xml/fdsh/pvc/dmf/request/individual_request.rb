# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            # IndividualRequest class
            #
            # @!attribute [rw] Applicant
            #   @return [Applicant] an Applicant object
            class IndividualRequest
              include HappyMapper

              # XML tag for IndividualRequest
              tag 'IndividualRequest'

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
              def self.domain_to_mapper(individual_request)
                mapper = self.new
                mapper.PersonSSNIdentification = individual_request.PersonSSNIdentification
                mapper.PersonName = PersonName.domain_to_mapper(individual_request.PersonName)
                mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(individual_request.PersonBirthDate)
                mapper.PersonSexCode = individual_request.PersonSexCode

                mapper
              end
            end
          end
        end
      end
    end
  end
end