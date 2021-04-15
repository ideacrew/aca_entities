# frozen_string_literal: true

module AcaEntities
  module Contracts
    module EnrollmentPeriods
      # Schema and validation rules for {AcaEntities::EnrollmentPeriods::SpecialEnrollmentPeriod}
      class SpecialEnrollmentPeriodContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :qualifying_life_event_kind required
        # @option opts [Date] :qle_on required
        # @option opts [Boolean] :is_valid optional
        # @option opts [Date] :effective_on_kind required
        # @option opts [Date] :effective_on required
        # @option opts [Date] :submitted_at required
        # @option opts [String] :title optional
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on required
        # @option opts [String] :qle_answer optional
        # @option opts [Date] :next_poss_effective_date optional
        # @option opts [Date] :option1_date optional
        # @option opts [Date] :option2_date optional
        # @option opts [Date] :option3_date optional
        # @option opts [Date] :optional_effective_on optional
        # @option opts [String] :csl_num optional
        # @option opts [String] :market_kind optional
        # @option opts [Boolean] :admin_flag optional
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          required(:qualifying_life_event_kind_reference).hash(
            AcaEntities::Contracts::QualifyingLifeEvents::QualifyingLifeEventKindReferenceContract.params
          )
          required(:qle_on).maybe(:date)
          required(:effective_on_kind).filled(:string)
          required(:submitted_at).filled(:date)
          required(:start_on).filled(:date)
          required(:end_on).filled(:date)
          required(:effective_on).filled(:date)

          optional(:is_valid).maybe(:bool)
          optional(:title).maybe(:string)
          optional(:qle_answer).maybe(:string)
          optional(:next_poss_effective_date).maybe(:date)
          optional(:option1_date).maybe(:date)
          optional(:option2_date).maybe(:date)
          optional(:option3_date).maybe(:date)
          optional(:optional_effective_on).maybe(:array)
          optional(:csl_num).maybe(:string, size?: 5..10)
          optional(:market_kind).maybe(:string)
          optional(:admin_flag).maybe(:bool)
          optional(:timestamp).hash(TimeStampContract.params)
        end
      end
    end
  end
end
