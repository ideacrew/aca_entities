# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligble::Eligibility
    class EligibilityContract < Dry::Validation::Contract
      params do
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        optional(:evidences).filled(:array)
        optional(:grants).filled(:array)
        required(:state_histories).filled(:array)
        optional(:timestamps).filled(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end

      rule(:evidences).each do
        next unless key? && value
        resource_name = self.class.resource_name_for(:evidence, value[:key])
        next if value.is_a?(resource_name)

        result = "#{resource_name}Contract".constantize.new.call(value)
        next unless result&.failure?
        key.failure(
          text: 'invalid state history',
          error: result.errors.to_h
        )
      end

      rule(:grants).each do
        next unless key? && value
        resource_name = self.class.resource_name_for(:grant, value[:key])
        next if value.is_a?(resource_name)

        result = "#{resource_name}Contract".constantize.new.call(value)
        next unless result&.failure?
        key.failure(
          text: 'invalid state history',
          error: result.errors.to_h
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
