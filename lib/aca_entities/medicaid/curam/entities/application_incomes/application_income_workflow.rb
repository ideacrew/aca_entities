# frozen_string_literal: true

require 'securerandom'

module AcaEntities
  module Medicaid
    module Curam
      module ApplicationIncomes
        # ApplicationIncomeWorkflow
        class ApplicationIncomeWorkflow < Sequent::Workflow
          OTHER_NON_COUNTABLE = /other non-countable income/i.freeze

          on Events::ApplicationIncomeCreated do |event|
            if (event.kind =~ OTHER_NON_COUNTABLE) && (event.status != "Deleted")
              command = Curam::IncomeVariances::RecordIncomeVarianceCommand.new({
                                                                                  aggregate_id: SecureRandom.uuid,
                                                                                  application_income_aggregate_id: event.aggregate_id
                                                                                })
              Sequent.command_service.execute_commands command
            end
          end

          on Events::ApplicationIncomeUpdated do |event|
            records_to_impact = Curam::IncomeVariances::IncomeVarianceRecord.where({
                                                                                     application_income_aggregate_id: event.aggregate_id
                                                                                   })
            if event.kind =~ OTHER_NON_COUNTABLE
              if records_to_impact.any?
                records_to_impact.each do |record|
                  command = Curam::IncomeVariances::ReopenIncomeVarianceCommand.new({
                                                                                      aggregate_id: record.aggregate_id
                                                                                    })
                  Sequent.command_service.execute_commands command
                end
              else
                command = Curam::IncomeVariances::RecordIncomeVarianceCommand.new({
                                                                                    aggregate_id: SecureRandom.uuid,
                                                                                    application_income_aggregate_id: event.aggregate_id
                                                                                  })
                Sequent.command_service.execute_commands command
              end
            else
              records_to_impact.each do |record|
                command = Curam::IncomeVariances::ResolveIncomeVarianceCommand.new({
                                                                                     aggregate_id: record.aggregate_id
                                                                                   })
                Sequent.command_service.execute_commands command
              end
            end
          end

          on Events::ApplicationIncomeVersionRecorded do |event|
            aggregate_id = event.application_income_aggregate_id
            command_attributes = event.attributes.except(:application_income_aggregate_id, :aggregate_id)
            command = if Curam::ApplicationIncomes::ApplicationIncomeRecord.where({ aggregate_id: aggregate_id }).any?
                        UpdateApplicationIncomeCommand.new(
                          command_attributes.merge({ :aggregate_id => aggregate_id })
                        )
                      else
                        CreateApplicationIncomeCommand.new(
                          command_attributes.merge({ :aggregate_id => aggregate_id })
                        )
                      end
            Sequent.command_service.execute_commands command
          end

          on Events::ApplicationIncomeDeleted do |event|
            records_to_impact = Curam::IncomeVariances::IncomeVarianceRecord.where({
                                                                                     application_income_aggregate_id: event.aggregate_id
                                                                                   })
            records_to_impact.each do |record|
              command = Curam::IncomeVariances::ResolveIncomeVarianceCommand.new({
                                                                                   aggregate_id: record.aggregate_id
                                                                                 })
              Sequent.command_service.execute_commands command
            end
          end
        end
      end
    end
  end
end