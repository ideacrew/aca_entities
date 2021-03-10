# frozen_string_literal: true

module AcaEntities
  # Entity for FosterCare.
  class FosterCare < Dry::Struct

    attribute :attested_foster_care,  Types::Bool.optional.meta(omittable: true)
    attribute :age_left_foster_care,  Types::Integer.optional.meta(omittable: true)
    attribute :foster_care_us_state_code,  Types::Integer.optional.meta(omittable: true)
    attribute :had_medicaid_during_foster_care, Types::Bool.optional.meta(omittable: true)
  end
end
