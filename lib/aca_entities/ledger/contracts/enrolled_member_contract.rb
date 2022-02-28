# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Contracts
      # Schema and validation rules for {AcaEntities::Ledger::EnrolledMember}
      class EnrolledMemberContract < Contract
        params do
          optional(:id).maybe(:string)
          optional(:coverage_period).filled(:string)

          required(:member).filled(MemberContract.params)
          required(:premium).filled(PremiumContract.params)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)

          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
