# frozen_string_literal: true

module AcaEntities
  module Contracts
    module EnrollmentPeriods
      # Schema and validation rules for {AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriodReference}
      class SpecialEnrollmentPeriodReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :qualifying_life_event_kind required
        # @option opts [String] :market_kind required
        # @option opts [Date] :qle_on required
        # @option opts [Date] :effective_on required
        # @option opts [Date] :submitted_at required
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on required
        # @option opts [Date] :next_poss_effective_date optional
        # @option opts [Date] :option1_date optional
        # @option opts [Date] :option2_date optional
        # @option opts [Date] :option3_date optional
        # @option opts [Date] :optional_effective_on optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          required(:qualifying_life_event_kind).filled(:hash)
          required(:market_kind).filled(:string)
          required(:qle_on).filled(:date)
          required(:start_on).filled(:date)
          required(:end_on).filled(:date)
          required(:submitted_at).filled(:date)
          required(:effective_on).filled(:date)
          optional(:next_poss_effective_date).filled(:date)
          optional(:option1_date).filled(:date)
          optional(:option2_date).filled(:date)
          optional(:option3_date).filled(:date)
          optional(:optional_effective_on).filled(:date)
          optional(:timestamp).filled(:hash)
        end

        rule(:qualifying_life_event_kind) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::QualifyingLifeEvents::QualifyingLifeEventKindReferenceContract.new.call(value)
              key.failure(text: "invalid qualifying life event kind", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid qualifying life event kind. Expected a hash.")
            end
          end
        end

        rule(:end_on, :start_on) do
          key.failure('End on must be after start on date') unless values[:end_on] > values[:start_on]
        end

        rule(:timestamp) do
          if key? && value
            if value.is_a?(Hash)
              result = TimeStampContract.new.call(value)
              key.failure(text: "invalid timestamp", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid timestamp. Expected a hash.")
            end
          end
        end
      end
    end
  end
end

