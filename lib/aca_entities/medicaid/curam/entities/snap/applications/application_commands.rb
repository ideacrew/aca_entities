module Ehs
  module Snap
    module Applications
      module ApplicationCommands
        class CreateApplication < Sequent::Command
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

        class UpdateApplication < Sequent::Command
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