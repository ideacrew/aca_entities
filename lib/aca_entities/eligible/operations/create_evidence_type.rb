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
        evidence_model = yield get_evidence_model_for(params)
        values = yield validate(evidence_model, params)
        evidence = yield create(evidence_model, values)

        Success(evidence)
      end

      private

      def validate(evidence_model, params)
        response = "#{evidence_model}Contract".constantize.new.call(params[:evidence])

        if response.success?
          Success(response.to_h)
        else
          Failure(response.errors.to_h)
        end
      end

      def create(evidence_model, values)
        Success(evidence_model.new(values))
      end

      def get_evidence_model_for(params)
        evidence_type = params[:subject].evidence_class_for(params[:evidence][:key])

        Success(evidence_type)
      end
    end
  end
end
