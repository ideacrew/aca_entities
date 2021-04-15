# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ParticipantRoles
        # CommandHandler for Participant role
        class CommandHandler < Sequent::CommandHandler
          on Commands::CreateRole do |command|
            repository.add_aggregate AggregateRoot.new(command)
          end

          on Commands::UpdateRole do |command|
            do_with_aggregate(command, AggregateRoot) do |aggregate|
              aggregate.update(command)
            end
          end
        end
      end
    end
  end
end