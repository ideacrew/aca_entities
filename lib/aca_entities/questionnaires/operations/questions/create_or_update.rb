# frozen_string_literal: true

module AcaEntities
  module Questionnaires
    module Operations
      module Questions

        class CreateOrUpdate
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

          # @param [String] key
          # @param [String] label
          # @param [String] description
          # @param [String] kind
          # @param [Mixed] default_value
          # @param [Array<Question>] dependent_questions
          # @param [Boolean] is_required
          # @param [Boolean] is_visible
          # @param [Boolean] is_enabled
          # @param [Integer] order
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