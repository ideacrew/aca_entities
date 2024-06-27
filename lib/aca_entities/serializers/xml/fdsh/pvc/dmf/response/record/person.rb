# frozen_string_literal: true

# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_name'
# require 'aca_entities/serializers/xml/fdsh/pvc/dmf/request/person_birth_date'

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # Person class
                #
                # @!attribute [rw] Applicant
                #   @return [Applicant] an Applicant object
                class Person
                  include HappyMapper
                  register_namespace 'ext', 'http://pvcdmfresp.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                  register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

                  # XML tag for Person
                  tag 'Person'
                  namespace 'ext'

                  # XML mapping rule for PersonSSNIdentification
                  # @return [PersonSSNIdentification]
                  has_one :person_ssn_identification, PersonSSNIdentification

                  # XML mapping rule for PersonName
                  # @return [PersonName]
                  has_one :person_name, PersonName

                  # XML mapping rule for PersonBirthDate
                  # @return [PersonBirthDate]
                  has_one :person_birth_date, PersonBirthDate

                  # XML mapping rule for PersonDeathDate
                  # @return [PersonDeathDate]
                  has_one :person_death_date, PersonDeathDate

                  # XML mapping rule for PersonSexCode
                  # @return [String]
                  element :person_sex_code, String, tag: 'PersonSexCode'

                  # This method maps domain objects to mapper objects
                  #
                  # @param applicant [Object] the domain object
                  # @return [Applicant] the mapper object
                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.PersonSSNIdentification = PersonSSNIdentification.domain_to_mapper(response.PersonSSNIdentification)
                    mapper.PersonName = PersonName.domain_to_mapper(response.PersonName)
                    mapper.PersonBirthDate = PersonBirthDate.domain_to_mapper(response.PersonBirthDate)
                    mapper.PersonDeathDate = PersonDeathDate.domain_to_mapper(response.PersonDeathDate)
                    mapper.PersonSexCode = response.PersonSexCode

                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      PersonSSNIdentification: person_ssn_identification&.to_hash,
                      PersonName: person_name&.to_hash,
                      PersonBirthDate: person_birth_date&.to_hash,
                      PersonDeathDate: person_death_date&.to_hash,
                      PersonSexCode: person_sex_code
                    }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
