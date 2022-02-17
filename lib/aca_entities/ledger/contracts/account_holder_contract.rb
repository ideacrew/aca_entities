# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::AccountHolder}
      class AccountHolderContract < Contract
        params do
          optional(:id).value(:string)
          optional(:person_name).filled(AcaEntities::Contracts::People::PersonNameContract.params)
          optional(:subscriber).filled(AcaEntities::Ledger::Contracts::MemberContract.params)
          optional(:account).filled(AcaEntities::Ledger::Contracts::AccountContract.params)
          optional(:policies).array(AcaEntities::Ledger::Contracts::PolicyContract.params)
          optional(:is_active).filled(:bool)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
