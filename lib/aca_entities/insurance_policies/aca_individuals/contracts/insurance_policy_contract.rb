#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsurancePolicy} entity
        class InsurancePolicyContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id)
            required(:policy_id).value(:string)
            optional(:insurer_policy_id).value(:string)
            required(:marketplace_segment_id).value(:string)
            required(:coverage_kind).value(AcaEntities::Types::AcaHealthInsuranceCoverageKind)
            required(:insurance_product).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract.params
            )
            optional(:edi_db_policy).maybe(:hash)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
