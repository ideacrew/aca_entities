# frozen_string_literal: true

module AcaEntities
  module Eligibility
    # Entity for specialEnrollmentperiod
    class SpecialEnrollmentPeriod < Dry::Struct

      attribute :married_with_in_last_60_days_code,                   Types::String.optional.meta(omittable: true)
      attribute :date_married,                                        Types::Date.optional.meta(omittable: true)
      attribute :will_loss_coverage_in_next_60_days_code,             Types::String.optional.meta(omittable: true)
      attribute :adopted_in_last_60_days_code,                        Types::String.optional.meta(omittable: true)
      attribute :date_of_adoption,                                    Types::Date.optional.meta(omittable: true)
      attribute :eligible_immigration_status_in_last_60_days_code,    Types::String.optional.meta(omittable: true)
      attribute :move_with_in_last_60_days_code,                      Types::String.optional.meta(omittable: true)
      attribute :moved_from_zip_code,                                 Types::String.optional.meta(omittable: true)
      attribute :previous_county_name,                                Types::String.optional.meta(omittable: true)
      attribute :date_moved,                                          Types::Date.optional.meta(omittable: true)
      attribute :incarceration_release_with_in_last_60_days_code,     Types::String.optional.meta(omittable: true)
      attribute :date_released_from_incarceration,                    Types::Date.optional.meta(omittable: true)
      attribute :date_gained_eligible_immigration_status,             Types::Date.optional.meta(omittable: true)
    end
  end
end
