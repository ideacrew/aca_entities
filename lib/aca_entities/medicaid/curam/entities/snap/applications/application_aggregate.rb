module Ehs
  module Snap
    module Applications
      class ApplicationAggregate < Sequent::AggregateRoot
        def initialize(command)
          super(command.aggregate_id)
          apply(
            ApplicationEvents::ApplicationCreated,
            {
              aggregate_id: command.aggregate_id,
              application_id: command.application_id,
              last_updated_on: command.last_updated_on,
              case_id: command.case_id,
              case_reference: command.case_reference,
              case_kind: command.case_kind,
              concern_role_id: command.concern_role_id,
              program_kind: command.program_kind,
              application_status: command.application_status,
              program_application_status: command.program_application_status,
              submitted_at: command.submitted_at
            }
          )
        end

        def update(command)
          if command.last_updated_on > @last_updated_on
            apply(
              ApplicationEvents::ApplicationUpdated,
              {
                aggregate_id: command.aggregate_id,
                last_updated_on: command.last_updated_on,
                application_status: command.application_status,
                program_application_status: command.program_application_status
              }
            )
          end
        end

        on ApplicationEvents::ApplicationCreated do |event|
          @last_updated_on = event.last_updated_on
          @submitted_at = event.submitted_at
          @application_id = event.application_id
          @case_id = event.case_id
          @case_reference = event.case_reference
          @case_kind = event.case_kind
          @concern_role_id = event.concern_role_id
          @program_kind = event.program_kind
          @application_status = event.application_status
          @program_application_status = event.program_application_status
        end

        on ApplicationEvents::ApplicationUpdated do |event|
          @last_updated_on = event.last_updated_on
          @application_status = event.application_status
          @program_application_status = event.program_application_status
        end
      end
    end
  end
end