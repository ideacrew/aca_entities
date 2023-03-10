# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      # entity for Member
      class Member < Dry::Struct
        attribute :exchange_assigned_member_id, Types::String.meta(omittable: false)
        attribute :member_name, MemberName.meta(omittable: false)
        attribute :birth_date, Types::String.meta(omittable: false)
        attribute :sex, Types::SexofIndividualTerminologyType.meta(omittable: false)
        attribute :ssn, Types::String.optional.meta(omittable: true)
        attribute :relationship, Types::PaynowMemberRelationshipCode.meta(omittable: false)
        attribute :is_subscriber, Types::Bool.meta(omittable: false)
      end
    end
  end
end