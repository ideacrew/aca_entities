# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::MarketplaceSegment}
      class MarketplaceSegmentContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:coverage_period).maybe(:string)
          required(:segment).filled(:string)
          required(:total_premium_amount).filled(AcaEntities::Types::Money)
          required(:total_premium_responsibility_amount).filled(AcaEntities::Types::Money)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:enrolled_members).array(EnrolledMemberContract.params)
          optional(:subscriber_hbx_id).maybe(:string)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
