# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module Rx1424
        module Contracts
          # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
          class CloseCaseRequestContract < Dry::Validation::Contract
            # @!method call(opts)
            # @param opts [Hash] the parameters to validate using this contract
            # @option opts [RequestIDType] :request_id A requester-assigned numeric ID that uniquely identifies the request
            # @option opts [AcaEntities::Fdsh::Person::PersonName] :person_name Applicant's full name
            # @option opts [FullyRestrictedSSNType] :identification_id Applicant last name
            # @option opts [TaxFilerCategoryCodeType] :tax_filer_category_code Applicant's income tax filing role
            # @return [Dry::Monads::Result]
            params do
              required(:CaseNumber).filled(:string)
            end
          end
        end
      end
    end
  end
end
