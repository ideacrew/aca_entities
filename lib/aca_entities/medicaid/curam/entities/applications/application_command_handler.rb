# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        # ApplicationCommandHandler
        class ApplicationCommandHandler < Sequent::CommandHandler
          on Commands::CreateApplication do |command|
            repository.add_aggregate ApplicationAggregate.new(command)
          end

          on Commands::UpdateApplication do |command|
            do_with_aggregate(command, ApplicationAggregate) do |aggregate|
              aggregate.update(command)
            end
          end

          on Commands::AddProgramApplication do |command|
            do_with_aggregate(command, ApplicationAggregate) do |aggregate|
              aggregate.add_program_application(command)
            end
          end

          on Commands::UpdateProgramApplication do |command|
            do_with_aggregate(command, ApplicationAggregate) do |aggregate|
              aggregate.update_program_application(command)
            end
          end
        end
      end
    end
  end
end