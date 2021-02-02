# frozen_string_literal: true

module AcaEntities
  module Questionnaires
    module Operations
      module Questions

        class CreateOrUpdate
          send(:include, Dry::Monads[:result, :do])
          send(:include, Dry::Monads[:try])

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