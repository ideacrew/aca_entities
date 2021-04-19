# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentExemption < Dry::Struct
      attribute :kind,                      AcaEntities::Types::EnrollmentExemptionKinds.optional.meta(omittable: false)
      attribute :certificate_number,        Types::String.optional.meta(omittable: false)
      attribute :start_date,                Types::Date.optional.meta(omittable: false)
      attribute :end_date,                  Types::Date.optional.meta(omittable: true)
      attribute :family_member_reference,   AcaEntities::Families::FamilyMemberReference.optional.meta(omittable: false)
      attribute :irs_group_reference,       AcaEntities::Groups::IrsGroupReference.optional.meta(omittable: false)
    end
  end
end

