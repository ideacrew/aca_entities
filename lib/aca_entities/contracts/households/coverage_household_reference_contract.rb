# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::CoverageHouseholdReference}
      class CoverageHouseholdReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_immediate_family required
        # @option opts [Boolean] :is_determination_split_household optional
        # @return [Dry::Monads::Result]
        params do
          optional(:start_date).value(:date?)
          optional(:end_date).value(:date?)
          required(:is_immediate_family).value(:bool?)
          optional(:is_determination_split_household).maybe(:bool)
        end
      end
    end
  end
end