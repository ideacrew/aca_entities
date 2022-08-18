# frozen_string_literal: true

module AcaEntities
  module AptcCsrEligibilitiesEnrollments
    module Contracts
      # Schema and validation rules for {}
      class AptcAccumulatorContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @return [Dry::Monads::Result]
        params do
          # Maximum Amount that is Available after any discounts in the System.
          required(:maximum_amount).filled(AcaEntities::Types::Money)
          required(:balance).filled(AcaEntities::Types::Money)
          optional(:accumulator_adjustments).array(AccumulatorAdjustmentContract.params)
        end
      end
    end
  end
end