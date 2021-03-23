# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Snap
        module Applications
          module ApplicationEvents
            # snap application created event
            class ApplicationCreated < Sequent::Event
              attrs(
                last_updated_on: DateTime,
                submitted_at: DateTime,
                application_id: String,
                case_id: String,
                case_reference: String,
                case_kind: String,
                concern_role_id: String,
                program_kind: String,
                application_status: String,
                program_application_status: String
              )
            end

            # snap application updated event
            class ApplicationUpdated < Sequent::Event
              attrs(
                last_updated_on: DateTime,
                application_status: String,
                program_application_status: String
              )
            end
          end
        end
      end
    end
  end
end