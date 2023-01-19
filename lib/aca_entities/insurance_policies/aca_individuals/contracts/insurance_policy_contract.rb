#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      module Contracts
        # Schema and validation rules for the {AcaEntities::InsurancePolicies::InsurancePolicy} entity
        class InsurancePolicyContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :assistance_year optional
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            optional(:id)
            required(:policy_id).value(:string)
            optional(:insurer_policy_id).value(:string)
            optional(:marketplace_segment_id).value(:string)
            optional(:carrier_policy_id).maybe(:string)
            optional(:term_for_np).maybe(:bool)
            optional(:coverage_kind).value(AcaEntities::Types::AcaHealthInsuranceCoverageKind)
            optional(:aasm_state).value(:string)
            required(:insurance_product).value(
              AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract.params
            )
            optional(:enrollments).array(AcaEntities::InsurancePolicies::Contracts::EnrollmentContract.params)
            optional(:aptc_csr_tax_households).array(AcaEntities::InsurancePolicies::AcaIndividuals::Contracts::AptcCsrTaxHouseholdContract.params)
            required(:start_on).value(:date)
            required(:hbx_enrollment_ids).value(:array)
            optional(:end_on).maybe(:date)
            optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
          end
        end
      end
    end
  end
end
