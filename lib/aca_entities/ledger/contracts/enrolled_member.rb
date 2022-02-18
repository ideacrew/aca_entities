# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::TaxHousehold}
      class TaxHouseholdContract < Contract
        params do
          optional(:id).filled(:string)
          required(:member).filled(MemberContract.params)
          required(:premium).filled(PremiumContract.params)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
