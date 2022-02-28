# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Member}
      class CustomerContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hbx_id).filled(:string)
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:customer_role).filled(:string)
          required(:account).filled(AcaEntities::Ledger::Contracts::AccountContract.params)
          required(:insurance_coverage).filled(AcaEntities::Ledger::Contracts::InsuranceCoverageContract.params)
          required(:is_active).filled(:bool)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
