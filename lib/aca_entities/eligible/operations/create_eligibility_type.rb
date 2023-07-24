# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

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
        eligibility_model = yield get_eligibility_model_for(params)
        values = yield validate(eligibility_model, params)
        evidence = yield create(eligibility_model, values)

        Success(evidence)
      end

      private

      def validate(eligibility_model, params)
        response = "#{eligibility_model}Contract".constantize.new.call(params[:eligibility])

        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def create(eligibility_model, values)
        Success(eligibility_model.new(values))
      end

      def get_eligibility_model_for(params)
        eligibility_type = params[:subject].eligbility_class_for(params[:eligibility][:key])

        Success(eligibility_type)
      end
    end
  end
end
