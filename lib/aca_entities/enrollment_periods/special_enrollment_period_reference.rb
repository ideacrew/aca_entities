# frozen_string_literal: true

module AcaEntities
  module EnrollmentPeriods
    class SpecialEnrollmentPeriodReference < Dry::Struct

      attribute :qualifying_life_event_kind_reference,
                AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference.optional.meta(omittable: true)
      attribute :qle_on,                                      Types::Date.optional.meta(omittable: true)
      attribute :start_on,                                    Types::Date.optional.meta(omittable: true)
      attribute :end_on,                                      Types::Date.optional.meta(omittable: true)
      attribute :effective_on,                                Types::Date.optional.meta(omittable: true)
      attribute :submitted_at,                                Types::Date.optional.meta(omittable: true)

      attribute :next_poss_effective_date,                    Types::Date.optional.meta(omittable: true)
      attribute :option1_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option2_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option3_date,                                Types::Date.optional.meta(omittable: true)
      attribute :optional_effective_on,                       Types::Array.optional.meta(omittable: true)
      attribute :timestamp,                                   AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
