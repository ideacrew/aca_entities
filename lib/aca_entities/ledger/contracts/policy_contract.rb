# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Policy}
      class PolicyContract < Contract
        params do
          optional(:id).value(:string)
          required(:insurer).filled(InsurerContract.params)
          required(:product).filled(ProductContract.params)
          required(:marketplace_segments).array(MarketplaceSegmentContract.params)
          required(:exchange_assigned_id).filled(:string)
          required(:subscriber_hbx_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          optional(:service_area_id).maybe(:string)
          required(:rating_area_id).filled(:string)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
