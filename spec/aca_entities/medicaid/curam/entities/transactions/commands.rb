module Ehs
  module Transactions
    module Commands

      class CreateTransaction < Sequent::Command
        attrs transaction: Ehs::Transactions::TransactionValueObject
      end
      
      class UpdateTransaction < Sequent::Command
        attrs transaction: Ehs::Transactions::TransactionValueObject
      end
    end
  end
end
