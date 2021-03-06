# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Snap
        module Applications
          # snap application command handler
          class ApplicationCommandHandler < Sequent::CommandHandler
            on ApplicationCommands::CreateApplication do |command|
              repository.add_aggregate ApplicationAggregate.new(command)
            end

            on ApplicationCommands::UpdateApplication do |command|
              do_with_aggregate(command, ApplicationAggregate) do |aggregate|
                aggregate.update(command)
              end
            end
          end
        end
      end
    end
  end
end