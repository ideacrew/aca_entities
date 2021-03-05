# frozen_string_literal: true

module AcaEntities
  module Questionnaires
    module Operations
      module Questions

        # Find a question.
        class Find
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

          # @param [String] questionaire_key
          # @param [String] namespace
          # @param [String] key
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
