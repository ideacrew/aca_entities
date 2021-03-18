# frozen_string_literal: true

module Ehs
  module ProductDeliveryCases
    module Commands
      class CreateCase < Sequent::Command
        attrs(
          last_updated_at: DateTime,
          case_reference: String,
          integrated_case_aggregate_id: String,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdateCase < Sequent::Command
        attrs(
          last_updated_at: DateTime,
          integrated_case_aggregate_id: String,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end