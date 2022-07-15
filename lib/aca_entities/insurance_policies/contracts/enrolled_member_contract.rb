# frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module Contracts
      # Schema and validation rules for {AcaEntities::InsurancePolicies::EnrolledMember}
      class EnrolledMemberContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:member).value(AcaEntities::InsurancePolicies::Contracts::MemberContract.params)
          required(:enrolled_member_premium).value(
            AcaEntities::InsurancePolicies::Contracts::EnrolledMemberPremiumContract.params
          )
          optional(:primary_care_provider).value(
            AcaEntities::InsurancePolicies::Contracts::HealthCarePractitionerContract.params
          )
          optional(:timestamps).maybe(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
