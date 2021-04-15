# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyMember < Dry::Struct
      # TODO: Person hbx_id until we add hbx_id on family member
      attribute :hbx_id,                                      Types::String.optional.meta(omittable: false)
      attribute :is_primary_applicant,                        Types::Bool.optional.meta(omittable: false)
      attribute :is_consent_applicant,                        Types::Bool.optional.meta(omittable: false)
      attribute :is_coverage_applicant,                       Types::Bool.optional.meta(omittable: false)
      attribute :is_active,                                   Types::Bool.optional.meta(omittable: true)
      attribute :applicant_reference,                         AcaEntities::MagiMedicaid::ApplicantReference.optional.meta(omittable: true)
      attribute :former_family_reference,                     AcaEntities::Families::FamilyReference.optional.meta(omittable: true)
      attribute :hbx_enrollment_exemptions,
                Types::Strict::Array.of(AcaEntities::Enrollments::HbxEnrollmentExemption).optional.meta(omittable: true)
      attribute :person,                                      AcaEntities::People::Person.optional.meta(omittable: false)
      attribute :timestamp,                                   AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end