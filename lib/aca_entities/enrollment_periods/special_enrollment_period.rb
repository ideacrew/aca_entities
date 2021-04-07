# frozen_string_literal: true

module AcaEntities
  module EnrollmentPeriods
    module SpecialEnrollmentPeriod

      attribute :qualifying_life_event_kind,                  AcaEntities::QualifyingLifeEvents::QualifyingLifeEventKindReference.meta(omittable: false)
      attribute :qle_on,                                      Types::Date.meta(omittable: false)
      attribute :is_valid,                                    Types::Bool.optional.meta(omittable: false)
      attribute :effective_on_kind,                           Types::String.meta(omittable: false)
      attribute :effective_on,                                Types::Date.meta(omittable: false)
      attribute :submitted_at,                                Types::Date.meta(omittable: false)
      attribute :title,                                       Types::String.optional.meta(omittable: false)
      attribute :start_on,                                    Types::Date.meta(omittable: false)
      attribute :end_on,                                      Types::Date.meta(omittable: false)
      attribute :qle_answer,                                  Types::String.optional.meta(omittable: false)
      attribute :next_poss_effective_date,                    Types::Date.optional.meta(omittable: false)
      attribute :option1_date,                                Types::Date.optional.meta(omittable: false)
      attribute :option2_date,                                Types::Date.optional.meta(omittable: false)
      attribute :option3_date,                                Types::Date.optional.meta(omittable: false)
      attribute :optional_effective_on,                       Types::Array.optional.meta(omittable: false)
      attribute :csl_num,                                     Types::String.optional.meta(omittable: false)
      attribute :market_kind,                                 Types::String.meta(omittable: false)
      attribute :admin_flag,                                  Types::Bool.optional.meta(omittable: false)
      attribute :timestamp,                                   AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end




