# frozen_string_literal: true

module AcaEntities
  module EnrollmentPeriods
    class SpecialEnrollmentPeriod < Dry::Struct

      attribute :qualifying_life_event_kind_reference,
                AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference.meta(omittable: false)
      attribute :qle_on,                                      Types::Date.meta(omittable: false)
      attribute :start_on,                                    Types::Date.meta(omittable: false)
      attribute :end_on,                                      Types::Date.meta(omittable: false)
      attribute :effective_on_kind,                           Types::String.meta(omittable: false)
      attribute :submitted_at,                                Types::Date.meta(omittable: false)
      attribute :effective_on,                                Types::Date.meta(omittable: false)

      attribute :is_valid,                                    Types::Bool.optional.meta(omittable: true)
      attribute :title,                                       Types::String.optional.meta(omittable: true)
      attribute :qle_answer,                                  Types::String.optional.meta(omittable: true)
      attribute :next_poss_effective_date,                    Types::Date.optional.meta(omittable: true)
      attribute :option1_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option2_date,                                Types::Date.optional.meta(omittable: true)
      attribute :option3_date,                                Types::Date.optional.meta(omittable: true)
      attribute :optional_effective_on,                       Types::Array.optional.meta(omittable: true)
      attribute :csl_num,                                     Types::String.optional.meta(omittable: true)
      attribute :market_kind,                                 Types::String.optional.meta(omittable: true)  # TODO: Revisit
      attribute :admin_flag,                                  Types::Bool.optional.meta(omittable: true)
      attribute :timestamp,                                   AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end




