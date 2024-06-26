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
                # IndividualResponse class
                #
                # @!attribute [rw] Applicant
                #   @return [Applicant] an Applicant object
                class IndividualResponse
                  include HappyMapper
                  register_namespace 'ext', 'http://pvcdmfresp.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                  register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'
                  register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                  # XML tag for IndividualResponse
                  tag 'IndividualResponse'
                  namespace 'ext'

                  # XML mapping rule for PersonSSNIdentification
                  # @return [PersonSSNIdentification]
                  has_one :person, Person

                  # XML mapping rule for PersonName
                  # @return [PersonName]
                  has_one :ssa_verification_supplement, SSAVerificationSupplement

                  # This method maps domain objects to mapper objects
                  #
                  # @param applicant [Object] the domain object
                  # @return [Applicant] the mapper object
                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.Person = Person.domain_to_mapper(response.Person)
                    mapper.SSAVerificationSupplement = SSAVerificationSupplement.domain_to_mapper(response.SSAVerificationSupplement)

                    mapper
                  end

                  # convert domain to hash
                  def to_hash
                    {
                      Person: person.to_hash,
                      SSAVerificationSupplement: ssa_verification_supplement.to_hash
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