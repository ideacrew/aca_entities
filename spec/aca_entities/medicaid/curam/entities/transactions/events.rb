module Ehs
  module Transactions
    module Events
      class TransactionCreated < Sequent::Event
        attrs aggregate_id: String, transaction: Ehs::Transactions::TransactionValueObject
      end

      class TransactionUpdated < Sequent::Event
        attrs aggregate_id: String, transaction: Ehs::Transactions::TransactionValueObject
      end
    end
  end
end


