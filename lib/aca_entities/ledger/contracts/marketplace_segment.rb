# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::TaxHousehold}
      class MarketplaceSegmentContract < Contract
        params do
          optional(:id).filled(:string)
          optional(:coverage_period).filled(:string)

          optional(:subscriber_hbx_id).filled(:string)
          optional(:policy_id).filled(:string)
          optional(:start_on).filled(:date)
          optional(:end_on).filled(:date)
          required(:segment).filled(:string)
          required(:enrolled_members).array(EnrolledMember.params)

          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
