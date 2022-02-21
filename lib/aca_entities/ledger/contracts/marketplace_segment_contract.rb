# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::TaxHousehold}
      class MarketplaceSegmentContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:coverage_period).filled(:string)

          optional(:subscriber_hbx_id).filled(:string)
          required(:total_premium_amount).filled(:float)
          required(:total_premium_responsibility_amount).filled(:float)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:segment).filled(:string)
          required(:enrolled_members).array(EnrolledMemberContract.params)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
