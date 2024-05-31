# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
              # IndividualRequest class
              #
              # @!attribute [rw] Applicant
              #   @return [Applicant] an Applicant object
              class IndividualRequest
                include HappyMapper

                # XML tag for IndividualRequest
                tag 'IndividualRequest'

                # XML mapping rule for Applicant
                # @return [Applicant]
                has_one :Applicant, Applicant

                # This method maps domain objects to mapper objects
                #
                # @param individual_request [Object] the domain object
                # @return [IndividualRequest] the mapper object
                def self.domain_to_mapper(individual_request)
                  mapper = self.new
                  mapper.Applicant = Applicant.domain_to_mapper(individual_request.Applicant)

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