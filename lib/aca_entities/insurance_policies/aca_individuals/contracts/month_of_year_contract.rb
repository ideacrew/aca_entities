#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::MonthOfYearContract} entity
        class MonthOfYearContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :assistance_year optional
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:month).value(:string)
            required(:coverage_information).hash(AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::CoverageInformationContract.params)
          end
        end
      end
    end
  end
end
