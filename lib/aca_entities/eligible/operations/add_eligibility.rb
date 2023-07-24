# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Eligible
    # Create Eligibility
    class AddEligibility
      send(:include, Dry::Monads[:result, :do])

      # @params [Hash] opts Options to create eligibility
      # @option opts [String] :subject required
      # @option opts [Hash] :eligibility required
      # @return [Dry::Monad] result
      def call(params)
        subject, elg_params = yield build_eligibility_params(params)
        eligibility_type = yield find_eligibility_type(subject, elg_params[:key])
        evidences = yield create_evidences(eligibility_type, elg_params)
        grants = yield create_grants(eligibility_type, elg_params)
        eligibility = yield create_eligibility(subject, elg_params, evidences, grants)

        Success(eligibility)
      end

      private

      def build_eligibility_params(params)
        subject = params[:subject].classify.constantize

        Success([subject, params[:eligibility]])
      end

      def find_eligibility_type(subject, eligibility_key)
        eligibility_type = subject.resource_name_for(:eligibility, eligibility_key)

        Success(eligibility_type)
      end

      def create_evidences(eligibility_type, elg_params)
        evidences = elg_params[:evidences].collect do |evidence_params|
          result = AcaEntities::Eligible::CreateEvidenceType.new.call({ subject: eligibility_type, evidence: evidence_params })
          return Failure(result.errors) if result.failure?
          result.success
        end

        Success(evidences)
      end

      def create_grants(eligibility_type, elg_params)
        grants = elg_params[:grants]&.collect do |grant_params|
          result = AcaEntities::Eligible::CreateGrantType.new.call({ subject: eligibility_type, grant: grant_params })
          return Failure(result.errors) if result.failure?
          result.success
        end

        Success(grants || [])
      end

      def create_eligibility(subject, elg_params, evidences, grants)
        elg_params.merge!(evidences: evidences, grants: grants)

        AcaEntities::Eligible::CreateEligibilityType.new.call({ subject: subject, eligibility: elg_params })
      end
    end
  end
end
