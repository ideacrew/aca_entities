# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::TaxHousehold}
      class TaxHouseholdContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:exchange_assigned_id).filled(:integer)
          required(:aptc_amount).filled(:decimal)
          optional(:csr).maybe(:integer)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
