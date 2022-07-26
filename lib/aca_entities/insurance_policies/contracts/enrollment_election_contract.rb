# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for the {AcaEntities::InsurancePolicies::EnrollmentElection} entity
      # Set of available benefit policies.  ACA Exchanges typically offer Health and Dental.  Other
      #   sponsors may offer those benefits plus others such as Life, Short/Long Term Disability, etc.
      class EnrollmentElectionContract < Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result::Success] if params pass validation
        # @return [Dry::Monads::Result::Failure] if params fail validation
        params do
          optional(:id).value(:string)
          required(:subscriber).value(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          optional(:dependents).array(AcaEntities::InsurancePolicies::Contracts::EnrolledMemberContract.params)
          required(:product_kind).value(AcaEntities::Types::AcaInsuranceProductKind)
          required(:product).value(AcaEntities::InsurancePolicies::Contracts::InsuranceProductContract.params)

          optional(:product_details).hash do
            optional(:coverage_kind).value(AcaEntities::Types::AcaHealthInsuranceCoverageKind)
            optional(:coverage_level_kind).value(AcaEntities::Types::AcaHealthInsuranceCoverageLevelKind)
            optional(:coverage_level_basis_kind).value(AcaEntities::Types::AcaHealthInsuranceCoverageLevelBasisKind)
          end

          required(:effective_date).value(:date)
          optional(:end_on).maybe(AcaEntities::Types::DateOrNil)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)

          # required(:enrollment_event_name).value(AcaEntities::InsurancePolicies::Types::EnrollmentEventKind)
          # required(:enrollment_event_payload).value(:hash)
        end
      end
    end
  end
end
