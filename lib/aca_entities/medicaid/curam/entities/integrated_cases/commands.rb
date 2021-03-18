module Ehs
  module IntegratedCases
    module Commands
      class CreateCase < Sequent::Command
        attrs(
          last_updated: DateTime,
          case_reference: String,
          case_kind: String,
          esnap_flag: Boolean,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdateCase < Sequent::Command
        attrs(
          last_updated: DateTime,
          case_reference: String,
          esnap_flag: Boolean,
          meta: ::Ehs::ValueObjects::Meta
        )

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end
