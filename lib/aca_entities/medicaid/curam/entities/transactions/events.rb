# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        module Events
          # event for Transaction create
          class TransactionCreated < Sequent::Event
            attrs aggregate_id: String, transaction: Curam::Transactions::TransactionValueObject
          end

          # command for Transaction update
          class TransactionUpdated < Sequent::Event
            attrs aggregate_id: String, transaction: Curam::Transactions::TransactionValueObject
          end
        end
      end
    end
  end
end


