#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::CoverageInformationContract} entity
        class CoverageInformationContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :assistance_year optional
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:tax_credit).value(:hash)
            required(:total_premium).value(:hash)
            required(:slcsp_benchmark_premium).value(:hash)
          end
        end
      end
    end
  end
end
