# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      class SbmiEnrollee < Dry::Struct
        attribute :exchange_assigned_memberId, Types::String.meta(omittable: false)
        attribute :subscriber_indicator, Types::String.meta(omittable: false)
        attribute :issuer_assigned_memberId, Types::String.optional.meta(omittable: true)
        attribute :person_last_name, Types::String.meta(omittable: false)
        attribute :person_first_name, Types::String.optional.meta(omittable: true)
        attribute :person_middle_name, Types::String.optional.meta(omittable: true)
        attribute :person_name_suffix, Types::String.optional.meta(omittable: true)
        attribute :birth_date, AcaEntities::Types::Date.meta(omittable: false)
        attribute :social_security_number, Types::String.optional.meta(omittable: true)
        attribute :gender_code, Types::String.optional.meta(omittable: true).default("U")
        attribute :postal_code, Types::String.meta(omittable: false)
        attribute :non_covered_subscriberInd, Types::String.optional.meta(omittable: true).default("N")
        attribute :member_start_date, AcaEntities::Types::Date.meta(omittable: false)
        attribute :member_end_date, AcaEntities::Types::Date.meta(omittable: false)
      end
    end
  end
end
