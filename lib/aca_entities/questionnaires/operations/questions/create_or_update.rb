# frozen_string_literal: true

module AcaEntities
  module Questionnaires
    module Operations
      module Questions

        # Create or update a question.
        class CreateOrUpdate
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

          # @param params [Hash] options to create or update the question
          # @option params [String] :key
          # @option params [String] :label
          # @option params [String] :description
          # @option params [String] :kind
          # @option params [Mixed] :default_value
          # @option params [Array<Question>] :dependent_questions
          # @option params [Boolean] :is_required
          # @option params [Boolean] :is_visible
          # @option params [Boolean] :is_enabled
          # @option params [Integer] :order
          # @return [Dry::Monad::Result] result
          def call(params)
            values    = yield validate(params)
            question  = yield find_or_create(values)

            Success(question)
          end

          private

          def validate(params)
          end

          def find_or_create(values)
          end
        end

      end
    end
  end
end
