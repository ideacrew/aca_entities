# frozen_string_literal: true

module AcaEntities
  module Questionnaires
    module Operations
      module OrderedTopics

        # Create or update an ordered topic.
        class CreateOrUpdate
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

          # @param [String] key
          # @param [String] title
          # @param [String] description
          # @param [Array<Glossary>] glossaries
          # @param [Array<OrderedTopics] ordered_topics
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
