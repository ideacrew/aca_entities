require 'securerandom'

module Ehs
  module ApplicationIncomes
    class ApplicationIncomeWorkflow < Sequent::Workflow
      OTHER_NON_COUNTABLE = /other non-countable income/i

      on Events::ApplicationIncomeCreated do |event|
        if (event.kind =~ OTHER_NON_COUNTABLE) && (event.status != "Deleted")
          command = Ehs::IncomeVariances::RecordIncomeVarianceCommand.new({
            aggregate_id: SecureRandom.uuid,
            application_income_aggregate_id: event.aggregate_id
          })
          Sequent.command_service.execute_commands command
        end
      end

      on Events::ApplicationIncomeUpdated do |event|
        records_to_impact = Ehs::IncomeVariances::IncomeVarianceRecord.where({
          application_income_aggregate_id: event.aggregate_id
        })
        if event.kind =~ OTHER_NON_COUNTABLE
          if records_to_impact.any?
            records_to_impact.each do |record|
              command = Ehs::IncomeVariances::ReopenIncomeVarianceCommand.new({
                aggregate_id: record.aggregate_id
              })
              Sequent.command_service.execute_commands command
            end
          else
            command = Ehs::IncomeVariances::RecordIncomeVarianceCommand.new({
              aggregate_id: SecureRandom.uuid,
              application_income_aggregate_id: event.aggregate_id
            })
            Sequent.command_service.execute_commands command
          end
        else
          records_to_impact.each do |record|
            command = Ehs::IncomeVariances::ResolveIncomeVarianceCommand.new({
              aggregate_id: record.aggregate_id
            })
            Sequent.command_service.execute_commands command
          end
        end
      end

      on Events::ApplicationIncomeVersionRecorded do |event|
        aggregate_id = event.application_income_aggregate_id
        command_attributes = event.attributes.except(:application_income_aggregate_id, :aggregate_id)
        if Ehs::ApplicationIncomes::ApplicationIncomeRecord.where({aggregate_id: aggregate_id}).any?
          command = UpdateApplicationIncomeCommand.new(
            command_attributes.merge({:aggregate_id => aggregate_id})
          )
          Sequent.command_service.execute_commands command
        else
          command = CreateApplicationIncomeCommand.new(
            command_attributes.merge({:aggregate_id => aggregate_id})
          )
          Sequent.command_service.execute_commands command
        end
      end

      on Events::ApplicationIncomeDeleted do |event|
        records_to_impact = Ehs::IncomeVariances::IncomeVarianceRecord.where({
          application_income_aggregate_id: event.aggregate_id
        })
        records_to_impact.each do |record|
          command = Ehs::IncomeVariances::ResolveIncomeVarianceCommand.new({
            aggregate_id: record.aggregate_id
          })
          Sequent.command_service.execute_commands command
        end
      end
    end
  end
end