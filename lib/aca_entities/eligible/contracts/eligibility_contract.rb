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

      rule(:evidences).each do |index|
        next unless key? && value
        entity_klass = self._contract.class.name.chomp('Contract').constantize
        resource_name = entity_klass.resource_name_for(:evidence, value[:key])
        next if value.is_a?(resource_name)

        result = "#{resource_name}Contract".constantize.new.call(value)
        if result&.failure?
          key.failure(
            text: 'invalid state history',
            error: result.errors.to_h
          )
        else
          values[:evidences][path.to_a[-1]] = resource_name.new(result.to_h)
        end
      end

      rule(:grants).each do
        next unless key? && value
        entity_klass = self._contract.class.name.chomp('Contract').constantize
        resource_name = entity_klass.resource_name_for(:grant, value[:key])
        next if value.is_a?(resource_name)

        result = "#{resource_name}Contract".constantize.new.call(value)
        if result&.failure?
          key.failure(
            text: 'invalid state history',
            error: result.errors.to_h
          )
        else
          values[:grants][path.to_a[-1]] = resource_name.new(result.to_h)
        end
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
