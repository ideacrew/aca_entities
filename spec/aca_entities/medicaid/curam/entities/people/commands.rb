module Ehs
  module People
    module Commands
      class CreatePerson < Sequent::Command
        attrs aggregate_id: String, person: PersonValueObject

        include ::Ehs::Commands::QuackLikeACreateOperation
      end

      class UpdatePerson < Sequent::Command
        attrs aggregate_id: String, person: PersonValueObject

        include ::Ehs::Commands::QuackLikeAnOperation
      end
    end
  end
end