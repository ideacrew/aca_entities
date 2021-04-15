# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module IntegratedCases
        module Commands
          # Command for CreateCase
          class CreateCase < Sequent::Command
            attrs(
              last_updated: DateTime,
              case_reference: String,
              case_kind: String,
              esnap_flag: Boolean,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeACreateOperation
          end

          class UpdateCase < Sequent::Command
            attrs(
              last_updated: DateTime,
              case_reference: String,
              esnap_flag: Boolean,
              meta: ::Curam::ValueObjects::Meta
            )

            include ::Curam::Commands::QuackLikeAnOperation
          end
        end
      end
    end
  end
end
