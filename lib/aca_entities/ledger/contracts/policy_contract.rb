# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Policy}
      class PolicyContract < Contract
        params do
          optional(:id).value(:string)
          required(:exchange_assigned_id).filled(:string)
          optional(:insurer_assigned_id).maybe(:string)
          required(:marketplace_segment_id).filled(:string)
          required(:product).filled(ProductContract.params)
          optional(:service_area_id).maybe(:string)
          required(:rating_area_id).filled(:string)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:enrolled_members)
            .array(:hash) do
              required(:member).filled(MemberContract.params)
              required(:premium).filled(PremiumContract.params)
              required(:start_on).filled(:date)
              optional(:end_on).maybe(:date)
            end
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
