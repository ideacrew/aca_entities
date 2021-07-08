# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyMember < Dry::Struct

      attribute :hbx_id,                                      Types::String.optional.meta(omittable: true)
      attribute :is_primary_applicant,                        Types::Bool.optional.meta(omittable: false)
      attribute :foreign_keys,                                Types::Array.of(AcaEntities::Identifiers::Id).optional.meta(omittable: true)
      attribute :is_consent_applicant,                        Types::Bool.optional.meta(omittable: true)
      attribute :is_coverage_applicant,                       Types::Bool.optional.meta(omittable: true)
      attribute :is_active,                                   Types::Bool.optional.meta(omittable: true)
      attribute :magi_medicaid_application_applicants,
                Types::Strict::Array.of(AcaEntities::MagiMedicaid::ApplicantReference).optional.meta(omittable: true)
      attribute :person,                                      AcaEntities::People::Person.optional.meta(omittable: false)
      attribute :timestamp,                                   AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
