# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC IndividualResponseContract
        class IndividualResponseContract < Dry::Validation::Contract
          params do
            required(:PersonSSNIdentification).filled(:string)
            required(:Insurances).array(AcaEntities::Fdsh::Pvc::Medicare::InsuranceContract.params)
            required(:OrganizationResponseCode).filled(:string)
            optional(:OrganizationResponseCodeText).filled(:string)
          end
        end
      end
    end
  end
end