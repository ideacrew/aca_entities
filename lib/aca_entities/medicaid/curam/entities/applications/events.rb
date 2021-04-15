# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        module Events
          # application created
          class ApplicationCreated < Sequent::Event
            attrs(
              {
                case_aggregate_id: String,
                status: String,
                submitted_at: DateTime,
                last_updated_at: DateTime,
                meta: ::Curam::ValueObjects::Meta
              }
            )
          end

          class ApplicationUpdated < Sequent::Event
            attrs(
              {
                status: String,
                last_updated_at: DateTime,
                meta: ::Curam::ValueObjects::Meta
              }
            )
          end

          class ProgramApplicationAdded < Sequent::Event
            attrs(
              {
                program_application: ValueObjects::ProgramApplication,
                program_applications: array(ValueObjects::ProgramApplication)
              }
            )
          end

          class ProgramApplicationUpdated < Sequent::Event
            attrs(
              {
                program_application: ValueObjects::ProgramApplication,
                program_applications: array(ValueObjects::ProgramApplication)
              }
            )
          end
        end
      end
    end
  end
end