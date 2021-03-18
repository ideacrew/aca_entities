module Ehs
  module Applications
    module Events
      class ApplicationCreated < Sequent::Event
        attrs(
          {
            case_aggregate_id: String,
            status: String,
            submitted_at: DateTime,
            last_updated_at: DateTime,
            meta: ::Ehs::ValueObjects::Meta
          }
        )
      end

      class ApplicationUpdated < Sequent::Event
        attrs(
          {
            status: String,
            last_updated_at: DateTime,
            meta: ::Ehs::ValueObjects::Meta
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