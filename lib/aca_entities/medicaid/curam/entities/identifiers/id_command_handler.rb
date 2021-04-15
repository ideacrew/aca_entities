# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        # id command handler
        class IdCommandHandler < Sequent::CommandHandler
          on Commands::CreateId do |command|
            repository.add_aggregate IdAggregate.new(command)
          end
        end
      end
    end
  end
end