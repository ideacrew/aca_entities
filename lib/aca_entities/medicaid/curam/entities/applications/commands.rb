# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        module Commands
          # CreateApplication
          class CreateApplication < Sequent::Command
            attrs(
              {
                case_aggregate_id: String,
                status: String,
                submitted_at: DateTime,
                last_updated_at: DateTime,
                meta: ::Curam::ValueObjects::Meta
              }
            )
            validates :meta, presence: true

            include ::Curam::Commands::QuackLikeACreateOperation
          end

          class UpdateApplication < Sequent::Command
            attrs(
              {
                status: String,
                last_updated_at: DateTime,
                meta: ::Curam::ValueObjects::Meta
              }
            )
            validates :meta, presence: true

            include ::Curam::Commands::QuackLikeAnOperation
          end

          class AddProgramApplication < Sequent::Command
            attrs(
              {
                program_application: ValueObjects::ProgramApplication
              }
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end

          class UpdateProgramApplication < Sequent::Command
            attrs(
              {
                program_application: ValueObjects::ProgramApplication
              }
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end
