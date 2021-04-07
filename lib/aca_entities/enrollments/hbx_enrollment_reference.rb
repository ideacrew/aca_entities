# frozen_string_literal: true

module AcaEntities
  module Enrollments
    class HbxEnrollmentReference < Dry::Struct

      attribute :hbx_id,                                          Types::String.meta(omittable: false)
      attribute :effective_on,                                    Types::Date.meta(omittable: false)
      attribute :aasm_state,                                      Types::String.meta(omittable: false)
      attribute :is_active,                                       Types::Bool.optional.meta(omittable: false)
      attribute :market_place_kind,                               Types::String.meta(omittable: false)
      attribute :enrollment_period_kind,                          Types::String.meta(omittable: false)
      attribute :product_kind,                                    Types::String.meta(omittable: false)
    end
  end
end