# frozen_string_literal: true

module AcaEntities
  module Eligibility
    class ChipWaitingPeriodBasis < Dry::Struct

      attribute :satisfied_code,        Types::String.meta(omittable: false)
      attribute :satisfied_indicator,   Types::Bool.optional.meta(omittable: true)
      attribute :determination_date,    Types::DateTime.optional.meta(omittable: true)
      attribute :ineligibility_reason,  Types::String.optional.meta(omittable: true)

    end
  end
end
