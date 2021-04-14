# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    class Relationship < Dry::Struct

      attribute :kind, Types::RelationshipKind.meta(omittable: false)
      attribute :applicant_reference, ApplicantReference.meta(omittable: false)
      attribute :relative_reference, ApplicantReference.meta(omittable: false)

      # Applicant's same_with_primary maps to this.
      attribute :lives_with_household_member, Types::Bool.optional.meta(omittable: true)
    end
  end
end