# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollment}
      class HbxEnrollmentMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :family_member required
        # @option opts [String] :carrier_member_id required
        # @option opts [Boolean] :is_subscriber required
        # @option opts [Hash] :premium_amount required
        # @option opts [Hash] :applied_aptc_amount required
        # @option opts [Date] :eligibility_date required
        # @option opts [Date] :coverage_start_on required
        # @option opts [Date] :coverage_end_on required
        # @return [Dry::Monads::Result]
        params do
          required(:family_member).filled(:hash)
          optional(:carrier_member_id).maybe(:string)
          required(:is_subscriber).filled(:bool)
          optional(:premium_amount).maybe(:hash)
          optional(:applied_aptc_amount).maybe(:hash)
          required(:eligibility_date).filled(:date)
          required(:coverage_start_on).filled(:date)
          optional(:coverage_end_on).maybe(:date)
        end

        rule(:coverage_end_on, :coverage_start_on) do
          if key? && value
            key.failure('must be on or after coverage_start_on.')  if values[:coverage_end_on] < values[:coverage_start_on]
          end
        end

        rule(:family_member) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyMemberReferenceContract.new.call(value)
              key.failure(text: "invalid family", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family. Expected a hash.")
            end
          end
        end

        rule(:premium_amount) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid premium_amount", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid premium_amount. Expected a hash.")
            end
          end
        end

        rule(:applied_aptc_amount) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrencyContract.new.call(value)
              key.failure(text: "invalid applied_aptc_amount", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid applied_aptc_amount. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
