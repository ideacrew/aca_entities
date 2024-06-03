# frozen_string_literal: true

# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name'
# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_birth_date'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Request
              # IndividualRequest class
              #
              # @!attribute [rw] Applicant
              #   @return [Applicant] an Applicant object
              class IndividualRequest
                include HappyMapper
                register_namespace 'ext', 'http://pvcdmfrqst.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

                # XML tag for IndividualRequest
                tag 'IndividualRequest'
                namespace 'ext'

                # XML mapping rule for PersonSSNIdentification
                # @return [String]
                has_one :PersonSSNIdentification, PersonSSNIdentification

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
                  mapper.PersonSSNIdentification = PersonSSNIdentification.domain_to_mapper(individual_request.PersonSSNIdentification)
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
end