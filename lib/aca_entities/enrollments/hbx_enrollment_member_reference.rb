# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentMemberReference < Dry::Struct

      attribute :is_subscriber,             Types::Strict::Bool.meta(omittable: false)
      attribute :premium_amount,            AcaEntities::Currency.meta(omittable: true)
      attribute :applied_aptc_amount,       AcaEntities::Currency.meta(omittable: true)
      attribute :eligibility_date,          Types::Date.meta(omittable: false)
      attribute :coverage_start_on,         Types::Date.meta(omittable: false)
      attribute :coverage_end_on,           Types::Date.optional.meta(omittable: true)
      attribute :tobacco_use,               Types::String.optional.meta(omittable: true)
    end
  end
end
