#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class EnrolledMember < Dry::Struct
      attribute :member,        AcaEntities::InsurancePolicies::Member.optional.meta(omittable: true)
      attribute :is_subscriber, Types::Bool.optional.meta(omittable: true)
      attribute :enrolled_member_premium,  AcaEntities::InsurancePolicies::EnrolledMemberPremium.optional.meta(omittable: true)
    end
  end
end