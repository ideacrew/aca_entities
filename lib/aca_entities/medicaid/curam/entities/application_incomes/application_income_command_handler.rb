# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeCommandHandler
        class ApplicationIncomeCommandHandler < Sequent::CommandHandler
          on RecordApplicationIncomeVersionCommand do |command|
            repository.add_aggregate ApplicationIncomeVersionAggregate.new(command)
          end

          on CreateApplicationIncomeCommand do |command|
            repository.add_aggregate ApplicationIncomeAggregate.new(command)
          end

          on UpdateApplicationIncomeCommand do |command|
            do_with_aggregate(command, ApplicationIncomeAggregate) do |aggregate|
              aggregate.update_attributes(command)
            end
          end
        end
      end
    end
  end
end