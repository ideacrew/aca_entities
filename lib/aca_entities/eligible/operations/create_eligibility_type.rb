# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

module AcaEntities
  module Eligible
    # Create EvidenceType
    class CreateEligibilityType
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

      def get_resource_name(params)
        resource_name =
          params[:subject].resource_name_for(
            :eligibility,
            params[:eligibility][:key]
          )

        Success(resource_name)
      end

      def validate(resource_name, params)
        response =
          "#{resource_name}Contract".constantize.new.call(params[:eligibility])
        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def validate_state_changes(resource_name, values)
        return Success(values) unless values[:state_histories]

        validator =
          StateChangeValidator.new(values[:state_histories], resource_name)
        validator.validate

        return Failure(validator.errors) unless validator.errors.empty?
        Success(values)
      end

      def create(resource_name, values)
        Success(resource_name.new(values))
      end
    end
  end
end
