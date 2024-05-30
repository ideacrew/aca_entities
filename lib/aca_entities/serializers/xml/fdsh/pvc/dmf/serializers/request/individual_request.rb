# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Serializers
            # Happymapper implementation for the root object of an Request.
              class IndividualRequest
                include HappyMapper

                tag 'IndividualRequest'

                has_one :Applicant, Applicant

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
