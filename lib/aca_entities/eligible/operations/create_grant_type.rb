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
        resource_name = yield get_resource_name(params)
        values = yield validate(resource_name, params)
        evidence = yield create(resource_name, values)

        Success(evidence)
      end

      private

      def get_resource_name(params)
        resource_name = params[:subject].resource_name_for(:grant, params[:grant][:key])

        Success(resource_name)
      end

      def validate(resource_name, params)
        response = "#{resource_name}Contract".constantize.new.call(params[:grant])

        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def create(resource_name, values)
        Success(resource_name.new(values))
      end
    end
  end
end
