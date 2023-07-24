# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::Evidence
    class EvidenceContract < Dry::Validation::Contract 
      params do
        required(:key).filled(:symbol)
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:is_satisfied).filled(:bool)
        required(:state_histories).filled(:array)
        optional(:timestamps).filled(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end

      rule(:state_histories).each do
        next unless key? && value
        next if value.is_a?(AcaEntities::Eligible::StateHistory)

        result =
          AcaEntities::Eligible::StateHistoryContract.new.call(value)
        next unless result&.failure?
        key.failure(
          text: 'invalid state history',
          error: result.errors.to_h
        )
      end
    end
  end
end
