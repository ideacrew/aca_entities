module Ehs
  module Applications
    class ApplicationAggregate < Sequent::AggregateRoot
      def initialize(command)
        super(command.aggregate_id)
        apply(
          Events::ApplicationCreated,
          {
            aggregate_id: command.aggregate_id,
            case_aggregate_id: command.case_aggregate_id,
            status: command.status,
            submitted_at: command.submitted_at,
            last_updated_at: command.last_updated_at,
            meta: command.meta
          }
        )
      end

      def update(command)
        application_updated = command.last_updated_at > @last_updated_at
        if application_updated
          apply(
            Events::ApplicationUpdated,
            {
              aggregate_id: command.aggregate_id,
              status: command.status,
              last_updated_at: command.last_updated_at,
              meta: command.meta
            }
          )
        end
      end

      def add_program_application(command)
        new_program_applications = @program_applications + [command.program_application]
        apply(
          Events::ProgramApplicationAdded,
          {
            aggregate_id: command.aggregate_id,
            program_application: command.program_application,
            program_applications: new_program_applications
          }
        )
      end

      def update_program_application(command)
        existing_program_application = @program_applications.detect do |pa|
          pa.aggregate_id == command.program_application.aggregate_id
        end
        other_program_applications = @program_applications.reject do |pa|
          pa.aggregate_id == command.program_application.aggregate_id
        end
        new_program_applications = other_program_applications + [command.program_application]
        if (command.program_application.last_updated_at > existing_program_application.last_updated_at)
          apply(
            Events::ProgramApplicationUpdated,
            {
              aggregate_id: command.aggregate_id,
              program_application: command.program_application,
              program_applications: new_program_applications
            }
          )
        end
      end

      on Events::ApplicationCreated do |event|
        @case_aggregate_id = event.case_aggregate_id
        @submitted_at = event.submitted_at
        @last_updated_at = event.last_updated_at
        @status = event.status
        @program_applications = []
      end

      on Events::ApplicationUpdated do |event|
        @last_updated_at = event.last_updated_at
        @status = event.status
      end

      on Events::ProgramApplicationAdded do |event|
        @program_applications = event.program_applications
      end

      on Events::ProgramApplicationUpdated do |event|
        @program_applications = event.program_applications
      end
    end
  end
end
