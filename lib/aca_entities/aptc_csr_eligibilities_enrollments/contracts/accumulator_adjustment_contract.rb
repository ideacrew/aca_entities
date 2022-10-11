# frozen_string_literal: true

module AcaEntities
  module AptcCsrEligibilitiesEnrollments
    module Contracts
      # Schema and validation rules for {}
      class AccumulatorAdjustmentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result]
        params do
          required(:enrollment).filled(AcaEntities::Contracts::Enrollments::HbxEnrollmentReferenceContract.params)
          required(:enrolled_member).filled(AcaEntities::Contracts::Enrollments::HbxEnrollmentMemberContract.params)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:amount).maybe(AcaEntities::Types::Money)
        end
      end
    end
  end
end