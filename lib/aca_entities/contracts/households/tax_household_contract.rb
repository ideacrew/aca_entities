# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::TaxHousehold}
      class TaxHouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Hash] :allocated_aptc optional
        # @option opts [Boolean] :is_eligibility_determined optional
        # @option opts [Date] :start_date optional
        # @option opts [Date] :end_date optional
        # @option opts [Array] :tax_household_members optional
        # @option opts [Array] :eligibility_determinations optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).maybe(:string)
          optional(:allocated_aptc).maybe(:hash)
          optional(:is_eligibility_determined).maybe(:bool)
          optional(:start_date).maybe(:date)
          optional(:end_date).maybe(:date)
          required(:tax_household_members).maybe(:array)
          optional(:eligibility_determinations).maybe(:array)
        end

        rule(:end_date, :start_date) do
          if values[:end_date]
            key.failure('End on must be after start on date') unless values[:end_date] >= values[:start_date]
          end
        end

        rule(:allocated_aptc) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid allocated aptc", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid allocated aptc. Expected a hash.")
            end
          end
        end

        rule(:tax_household_members).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::TaxHouseholdMemberContract.new.call(value)
              key.failure(text: "invalid tax household member.", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid tax household member. Expected a hash.")
            end
          end
        end

        rule(:eligibility_determinations).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Determinations::EligibilityDeterminationContract.new.call(value)
              key.failure(text: "invalid eligibility determination", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid eligibility determination. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
