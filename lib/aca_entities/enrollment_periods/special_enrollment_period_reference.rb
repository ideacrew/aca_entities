# frozen_string_literal: true

module AcaEntities
  module EnrollmentPeriods
    class SpecialEnrollmentPeriodReference < Dry::Struct

      attribute :qualifying_life_event_kind_reference,
                AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference.meta(omittable: false)
      attribute :qle_on,                                      Types::Date.meta(omittable: false)
      attribute :start_on,                                    Types::Date.meta(omittable: false)
      attribute :end_on,                                      Types::Date.meta(omittable: false)
      attribute :effective_on,                                Types::Date.meta(omittable: false)

      attribute :next_poss_effective_date,                    Types::Date.optional.meta(omittable: true)
      attribute :option1_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option2_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option3_date,                                Types::Date.optional.meta(omittable: true)
      attribute :optional_effective_on,                       Types::Array.optional.meta(omittable: true)
      attribute :timestamp,                                   AcaEntities::TimeStamp.meta(omittable: true)
    end
  end
end

