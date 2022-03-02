# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Transaction}
      class TransactionHeaderContract < Contract
        params do
          required(:code).filled(:integer)
          required(:application_extract_time).filled(:date_time)
          required(:policy_maintenance_time).filled(:date_time)
        end
      end
    end
  end
end
