# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentExemption < Dry::Struct
      attribute :kind,                      Types::String.optional.meta(omittable: false)
      attribute :certificate_number,        Types::String.optional.meta(omittable: false)
      attribute :start_date,                Types::Date.optional.meta(omittable: false)
      attribute :end_date,                  Types::Date.optional.meta(omittable: false)
      attribute :family_member,             AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: false)
      attribute :irs_group,                 AcaEntities::Groups::IrsGroup.optional.meta(omittable: false)
    end
  end
end

