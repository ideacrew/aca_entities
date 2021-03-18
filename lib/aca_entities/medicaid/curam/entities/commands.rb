require 'dry/monads'
require 'dry/monads/do'

module Ehs
  module Commands
    module QuackLikeACreateOperation
      extend ActiveSupport::Concern

      included do
        extend Dry::Monads[:result]
      end

      class_methods do
        def call(attrs = {})
          aggregate_id = Sequent.new_uuid
          command = new(attrs.merge({aggregate_id: aggregate_id}))
          if command.valid?
            Sequent.command_service.execute_commands command
            Success(aggregate_id)
          else
            Failure(command.errors)
          end
        end
      end
    end

    module QuackLikeAnOperation
      extend ActiveSupport::Concern

      included do
        extend Dry::Monads[:result]
      end

      class_methods do
        def call(attrs = {})
          command = new(attrs)
          if command.valid?
            Sequent.command_service.execute_commands command
            Success(command.aggregate_id)
          else
            Failure(command.errors)
          end
        end
      end
    end
  end
end