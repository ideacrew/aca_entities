# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module ProductDeliveryCases
        module Commands
          # Create case command
          class CreateCase < Sequent::Command
            attrs(
              last_updated_at: DateTime,
              case_reference: String,
              integrated_case_aggregate_id: String,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeACreateOperation
          end

          # update case command
          class UpdateCase < Sequent::Command
            attrs(
              last_updated_at: DateTime,
              integrated_case_aggregate_id: String,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end