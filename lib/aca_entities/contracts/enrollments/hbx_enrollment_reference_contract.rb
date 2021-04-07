# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollment}
      class HbxEnrollmentReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Date] :effective_on required
        # @option opts [String] :aasm_state required
        # @option opts [String] :market_place_kind required
        # @option opts [String] :enrollment_period_kind required
        # @option opts [Hash] :product_kind required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).filled(:string)
          required(:effective_on).filled(:date)
          required(:aasm_state).filled(:string)
          required(:market_place_kind).filled(
            AcaEntities::Types::EnrollmentMarketPlaceKinds
          )
          required(:enrollment_period_kind).filled(
            AcaEntities::Types::EnrollmentKinds
          )
          required(:product_kind).filled(
            AcaEntities::Types::ProductKinds
          )
        end
      end
    end
  end
end