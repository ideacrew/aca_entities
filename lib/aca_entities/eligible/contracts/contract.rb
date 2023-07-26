# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligble::Eligibility
    class Contract < Dry::Validation::Contract
      def resource_name_for(type, value)
        entity_klass = self.class.name.chomp("Contract").constantize
        entity_klass.resource_name_for(type, value[:key])
      end

      rule(:evidences).each do
        next unless key? && value
        resource_name = resource_name_for(:evidence, value)
        unless value.is_a?(resource_name)
          result = "#{resource_name}Contract".constantize.new.call(value)
          if result&.failure?
            key.failure(text: "invalid evidence", error: result.errors.to_h)
          else
            values[:evidences][path.to_a[-1]] = resource_name.new(result.to_h)
          end
        end
      end

      rule(:grants).each do
        next unless key? && value
        resource_name = resource_name_for(:grant, value)
        unless value.is_a?(resource_name)
          result = "#{resource_name}Contract".constantize.new.call(value)
          if result&.failure?
            key.failure(text: "invalid grant", error: result.errors.to_h)
          else
            values[:grants][path.to_a[-1]] = resource_name.new(result.to_h)
          end
        end
      end

      rule(:state_histories).each do
        next unless key? && value
        next if value.is_a?(AcaEntities::Eligible::StateHistory)

        result = AcaEntities::Eligible::StateHistoryContract.new.call(value)
        next unless result&.failure?
        key.failure(text: "invalid state history", error: result.errors.to_h)
      end
    end
  end
end
