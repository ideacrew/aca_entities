# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Eligible
    # Create EvidenceType
    class CreateEvidenceType
      send(:include, Dry::Monads[:result, :do])

      # @param [Hash] opts Options to build evidence
      # @option opts [String] :subject required
      # @option opts [Hash] :evidence required
      # @return [Dry::Monad] result
      def call(params)
        resource_name = yield get_resource_name(params)
        values = yield validate(resource_name, params)
        _result = yield validate_state_changes(resource_name, values)
        evidence = yield create(resource_name, values)

        Success(evidence)
      end

      private

      def validate(resource_name, params)
        response = "#{resource_name}Contract".constantize.new.call(params[:evidence])

        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def create(resource_name, values)
        Success(resource_name.new(values))
      end

      def validate_state_changes(resource_name, values)
        return Success(values) unless values[:state_history]
        validator = StateChangeValidator.new(values[:state_history], resource_name)
        validator.validate

        validator.errors.empty? ? Success(values) : Failure(validator.errors)
      end

      def get_resource_name(params)
        resource_name = params[:subject].resource_name_for(:evidence, params[:evidence][:key])

        Success(resource_name)
      end
    end
  end
end
