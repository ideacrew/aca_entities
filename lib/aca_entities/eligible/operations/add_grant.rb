# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Eligible
    # Create grant for an eligibility
    class AddGrant
      send(:include, Dry::Monads[:result, :do])

      # @params [Hash] opts Options to add evidence for an existing eligibility
      # @option opts [String] :subject required
      # @option opts [Hash] :grant required
      # @option opts [Hash] :eligibility required
      # @return [Dry::Monad] result
      def call(params)
        values = yield validate_input_params(params)
        eligibility_type = yield find_eligibility_type(values)
        grant = yield create_grant(eligibility_type, values)
        eligibility = yield update_eligibility(values, grant)

        Success([grant, eligibility])
      end

      private

      def validate_input_params(params)
        return Failure('subject is required') unless params[:subject]
        return Failure('eligibility is required') unless params[:eligibility]
        return Failure('grant is required') unless params[:grant]

        params[:subject] = params[:subject].classify.constantize
        Success(params)
      end

      def find_eligibility_type(values)
        eligibility_type = values[:subject].resource_name_for(:eligibility, values[:eligibility][:key])

        Success(eligibility_type)
      end

      def create_grant(eligibility_type, values)
        AcaEntities::Eligible::CreateGrantType.new.call({ subject: eligibility_type, grant: values[:grant] })
      end

      def update_eligibility(values, grant)
        (values[:eligibility][:grants] ||= []) << grant

        AcaEntities::Eligible::CreateEligibilityType.new.call({ subject: values[:subject], eligibility: values[:eligibility] })
      end
    end
  end
end
