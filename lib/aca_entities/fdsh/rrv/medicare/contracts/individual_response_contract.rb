# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV IndividualResponseContract
        class IndividualResponseContract < Dry::Validation::Contract
          params do
            required(:PersonSSNIdentification).filled(:string)
            required(:Insurances).array(AcaEntities::Fdsh::Rrv::Medicare::InsuranceContract.params)
            required(:OrganizationResponseCode).filled(:string)
            optional(:OrganizationResponseCodeText).filled(:string)
          end
        end
      end
    end
  end
end