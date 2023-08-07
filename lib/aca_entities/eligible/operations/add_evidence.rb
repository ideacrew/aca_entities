# frozen_string_literal: true

require "dry/monads"
require "dry/monads/do"

module AcaEntities
  module Eligible
    # Create evidence for an eligibility
    class AddEvidence
      send(:include, Dry::Monads[:result, :do])

      # @params [Hash] opts Options to add evidence for an existing eligibility
      # @option opts [String] :subject required
      # @option opts [Hash] :evidence required
      # @option opts [Hash] :eligibility required
      # @return [Dry::Monad] result
      def call(params)
        values = yield validate_input_params(params)
        eligibility_type = yield find_eligibility_type(values)
        evidence = yield create_evidence(eligibility_type, values)
        eligibility = yield update_eligibility(values, evidence)

        Success([evidence, eligibility])
      end

      private

      def validate_input_params(params)
        return Failure("subject is required") unless params[:subject]
        return Failure("eligibility is required") unless params[:eligibility]
        return Failure("evidence is required") unless params[:evidence]

        params[:subject] = params[:subject].classify.constantize
        Success(params)
      rescue StandardError => e
        Failure(e.message)
      end

      def find_eligibility_type(values)
        eligibility_type =
          values[:subject].resource_name_for(
            :eligibility,
            values[:eligibility][:key]
          )

        Success(eligibility_type)
      end

      def create_evidence(eligibility_type, values)
        AcaEntities::Eligible::CreateEvidenceType.new.call(
          { subject: eligibility_type, evidence: values[:evidence] }
        )
      end

      def update_eligibility(values, evidence)
        (values[:eligibility][:evidences] ||= []) << evidence

        AcaEntities::Eligible::CreateEligibilityType.new.call(
          { subject: values[:subject], eligibility: values[:eligibility] }
        )
      end
    end
  end
end
