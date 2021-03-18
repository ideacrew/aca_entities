module Ehs
  module Applications
    module Commands
      class CreateApplication < Sequent::Command
        attrs(
          {
            case_aggregate_id: String,
            status: String,
            submitted_at: DateTime,
            last_updated_at: DateTime,
            meta: ::Ehs::ValueObjects::Meta
          }
        )
        validates :meta, presence: true

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdateApplication < Sequent::Command
        attrs(
          {
            status: String,
            last_updated_at: DateTime,
            meta: ::Ehs::ValueObjects::Meta
          }
        )
        validates :meta, presence: true

        include ::Ehs::Commands::QuackLikeAnOperation
      end

      class AddProgramApplication < Sequent::Command
        attrs(
          {
            program_application: ValueObjects::ProgramApplication
          }
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end

      class UpdateProgramApplication < Sequent::Command
        attrs(
          {
            program_application: ValueObjects::ProgramApplication
          }
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end
