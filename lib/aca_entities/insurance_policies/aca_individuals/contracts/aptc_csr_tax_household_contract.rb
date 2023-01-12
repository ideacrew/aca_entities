#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::AptcCsrTaxHouseholdContract} entity
        class AptcCsrTaxHouseholdContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :assistance_year optional
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id).value(:string)
            required(:covered_individuals).array(AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::CoveredIndividualContract.params)
            optional(:months_of_year).array(AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::MonthOfYearContract.params)
          end
        end
      end
    end
  end
end
