# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Issuer}
      class TaxHouseholdContract < Contract
        params do
          optional(:id).filled(:string)
          optional(:cms_assigned_id).filled(:string)
          optional(:name).filled(:string)
          optional(:description).filled(:string)
          optional(:billing_periods)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
