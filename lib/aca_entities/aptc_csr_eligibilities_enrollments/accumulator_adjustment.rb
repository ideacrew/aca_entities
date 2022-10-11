# frozen_string_literal: true

module AcaEntities
  module AptcCsrEligibilitiesEnrollments
    class AccumulatorAdjustment < Dry::Struct

      attribute :enrollment, (AcaEntities::Enrollments::HbxEnrollmentReference).meta(omittable: false)
      attribute :enrolled_member, (AcaEntities::Enrollments::HbxEnrollmentMember).meta(omittable: false)
      attribute :start_on, Types::Date.meta(omittable: false)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
      attribute :amount, AcaEntities::Types::Money.optional.meta(omittable: true)

    end
  end
end