# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::TaxHousehold}
      class TaxHouseholdContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:aptc_amount).maybe(:float)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:csr).maybe(:integer)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
