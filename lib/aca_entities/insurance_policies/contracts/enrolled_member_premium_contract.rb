# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::EnrolledMemberPremium}
      class EnrolledMemberPremiumContract < Contract
        params do
          optional(:id).maybe(:string)

          # Rating table used to deteminte the insurance rate
          required(:premium_schedule).value(AcaEntities::InsurancePolicies::Contracts::PremiumScheduleContract.params)
          required(:insurance_rate).value(AcaEntities::Types::Money)
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
