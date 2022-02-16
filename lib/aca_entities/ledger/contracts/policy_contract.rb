# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::Policy}
      class PolicyContract < Contract
        params do
          optional(:id).value(:string)
          optional(:exchange_assigned_id).filled(:string)
          optional(:issuer_assigned_id).filled(:string)
          optional(:marketplace_segment_id).filled(:string)
          optional(:product).filled(:product)
          optional(:service_area).filled(:string)
          optional(:rating_area).filled(:string)
          optional(:start_on).filled(:date)
          optional(:end_on).filled(:date)
          optional(:enrolled_members).array do
            optional(:member).filled(:member)
            optional(:premium_amount).filled(:premium)
            optional(:start_on).filled(:date)
            optional(:end_on).filled(:date)
          end
          optional(:timestamps).filled(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
