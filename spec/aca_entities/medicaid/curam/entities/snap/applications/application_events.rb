module Ehs
  module Snap
    module Applications
      module ApplicationEvents
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