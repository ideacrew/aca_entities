# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::AccountHolder}
      class CustomerAccountContract < Contract
        params do
          optional(:id).value(:string)
          required(:customer).filled(AcaEntities::Ledger::Contracts::MemberContract.params)
          required(:customer_id).filled(:string)
          required(:account).filled(AcaEntities::Ledger::Contracts::AccountContract.params)
          required(:tax_households).array(TaxHouseholdContract.params)
          required(:policies).array(AcaEntities::Ledger::Contracts::PolicyContract.params)
          required(:is_active).filled(:bool)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
