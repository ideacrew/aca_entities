# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::InsuranceCoverage}
      class InsuranceCoverageContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hbx_id).filled(:string)
          optional(:tax_households).array(TaxHouseholdContract.params)
          required(:policies).array(AcaEntities::Ledger::Contracts::PolicyContract.params)
          required(:is_active).filled(:bool)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
