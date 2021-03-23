# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Transactions
        module Commands
          # command for Transaction create
          class CreateTransaction < Sequent::Command
            attrs transaction: Curam::Transactions::TransactionValueObject
          end

          # command for Transaction update
          class UpdateTransaction < Sequent::Command
            attrs transaction: Curam::Transactions::TransactionValueObject
          end
        end
      end
    end
  end
end
