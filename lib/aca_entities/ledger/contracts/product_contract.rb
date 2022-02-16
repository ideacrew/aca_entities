# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Product}
      class ProductContract < Contract
        params do
          optional(:id).filled(:string)
          optional(:issuer_assigned_id).filled(:string)
          optional(:exchange_assigned_id).filled(:string)
          optional(:hios_id).filled(:string)
          optional(:service_area).filled(:string)
          optional(:effective_year).filled(:integer)
          optional(:name).filled(:string)
          optional(:description).filled(:string)
          optional(:kind).filled(AcaEntities::Ledger::Types::InsuranceProductKind)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
