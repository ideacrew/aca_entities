# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        # command handler for ProductDeliveryCases
        class CommandHandler < Sequent::CommandHandler
          on Commands::CreateCase do |command|
            repository.add_aggregate ProductDeliveryCaseAggregate.new(command)
          end

          on Commands::UpdateCase do |command|
            do_with_aggregate(command, ProductDeliveryCaseAggregate) do |aggregate|
              aggregate.update(command)
            end
          end
        end
      end
    end
  end
end