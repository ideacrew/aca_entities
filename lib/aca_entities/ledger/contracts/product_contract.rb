# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Product}
      class ProductContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:hios_id).filled(:string)
          required(:effective_year).filled(:integer)
          optional(:name).maybe(:string)
          optional(:description).maybe(:string)
          required(:kind).filled(AcaEntities::Ledger::Types::InsuranceProductKind)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
