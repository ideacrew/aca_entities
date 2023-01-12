#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::CoveredIndividualContract} entity
        class CoveredIndividualContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :assistance_year optional
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:coverage_start_on).value(:date)
            required(:coverage_end_on).value(:date)
            required(:person_hbx_id).value(:string)
            optional(:filer_status).value(:string)
            optional(:relation_with_primary).value(:string)
          end
        end
      end
    end
  end
end
