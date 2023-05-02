# frozen_string_literal: true

module AcaEntities
  module Contracts
    module EnrollmentPeriods
      # Schema and validation rules for {AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriodReference}
      class SpecialEnrollmentPeriodReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :qualifying_life_event_kind optional
        # @option opts [String] :market_kind optional
        # @option opts [Date] :qle_on optional
        # @option opts [Date] :effective_on optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @option opts [Date] :next_poss_effective_date optional
        # @option opts [Date] :option1_date optional
        # @option opts [Date] :option2_date optional
        # @option opts [Date] :option3_date optional
        # @option opts [Date] :optional_effective_on optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:qualifying_life_event_kind_reference).hash(
            AcaEntities::Contracts::QualifyingLifeEvents::QualifyingLifeEventKindReferenceContract.params
          )
          optional(:qle_on).value(:date)
          optional(:start_on).value(:date)
          optional(:end_on).value(:date)
          optional(:submitted_at).value(:date)
          optional(:effective_on).value(:date)

          optional(:next_poss_effective_date).value(:date)
          optional(:option1_date).value(:date)
          optional(:option2_date).value(:date)
          optional(:option3_date).value(:date)
          optional(:optional_effective_on).value(:array?)
          optional(:timestamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end

