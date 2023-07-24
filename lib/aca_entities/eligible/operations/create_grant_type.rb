# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Eligible
    # Create GrantType
    class CreateGrantType
      send(:include, Dry::Monads[:result, :do])

      # @param [Hash] opts Options to build grant
      # @option opts [String] :subject required
      # @option opts [Hash] :evidence required
      # @return [Dry::Monad] result
      def call(params)
        grant_model = yield get_grant_model_for(params)
        values = yield validate(grant_model, params)
        evidence = yield create(grant_model, values)

        Success(evidence)
      end

      private

      def validate(grant_model, params)
        response = "#{grant_model}Contract".constantize.new.call(params[:grant])

        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def create(grant_model, values)
        Success(grant_model.new(values))
      end

      def get_grant_model_for(params)
        grant_type = params[:subject].grant_class_for(params[:grant][:key])

        Success(grant_type)
      end
    end
  end
end
