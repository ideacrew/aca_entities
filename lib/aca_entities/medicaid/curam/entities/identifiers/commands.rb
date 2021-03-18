module Ehs
  module Identifiers
    module Commands
      class CreateId < Sequent::Command
        attrs(
          key: String,
          item: String,
          start_on: DateTime,
          identifiable_id: String,
          identifiable_type: String
        )

        include ::Ehs::Commands::QuackLikeACreateOperation
      end
    end
  end
end