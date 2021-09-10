# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV IndividualResponseContract
        class IndividualResponseContract < Dry::Validation::Contract
          params do
            optional(:PersonSSNIdentification).filled(:string)
            optional(:Insurance).array(AcaEntities::Fdsh::Rrv::Medicare::InsuranceContract.params)
            optional(:OrganizationResponseCode).filled(:string)
            optional(:OrganizationResponseCodeText).filled(:string)
          end
        end
      end
    end
  end
end