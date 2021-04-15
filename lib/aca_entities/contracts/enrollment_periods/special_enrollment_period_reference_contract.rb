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
          required(:qualifying_life_event_kind_reference).hash(
            AcaEntities::Contracts::QualifyingLifeEvents::QualifyingLifeEventKindReferenceContract.params
          )
          required(:qle_on).filled(:date)
          required(:start_on).filled(:date)
          required(:end_on).filled(:date)
          required(:submitted_at).filled(:date)
          required(:effective_on).filled(:date)

          optional(:next_poss_effective_date).maybe(:date)
          optional(:option1_date).maybe(:date)
          optional(:option2_date).maybe(:date)
          optional(:option3_date).maybe(:date)
          optional(:optional_effective_on).maybe(:date)
          optional(:timestamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

