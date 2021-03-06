# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Comments
        # CommandHandler comments
        class CommandHandler < Sequent::CommandHandler
          on Commands::AddComment do |command|
            repository.add_aggregate AggregateRoot.new(command)
          end

          on Commands::UpdateComment do |command|
            do_with_aggregate(command, AggregateRoot) do |aggregate|
              aggregate.update(command)
            end
          end
        end
      end
    end
  end
end