# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Identifiers
        module Commands
          # commands for id create
          class CreateId < Sequent::Command
            attrs(
              key: String,
              item: String,
              start_on: DateTime,
              identifiable_id: String,
              identifiable_type: String
            )

            include ::Curam::Commands::QuackLikeACreateOperation
          end
        end
      end
    end
  end
end