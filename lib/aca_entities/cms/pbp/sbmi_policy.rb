# frozen_string_literal: true

module AcaEntities
  module Cms
    module Pbp
      class SbmiPolicy < Dry::Struct
        attribute :record_control_number,  Types::Integer.meta(omittable: false)
        attribute :qhp_id,    Types::String.meta(omittable: false)
        attribute :rating_area,  Types::String.meta(omittable: false)
        attribute :exchange_policy_id,  Types::String.meta(omittable: false)
        attribute :exchange_subscriber_id,  Types::String.meta(omittable: false)
        attribute :issuer_policy_id,  Types::String.optional.meta(omittable: true)
        attribute :issuer_subscriber_id,  Types::String.optional.meta(omittable: true)
        attribute :coverage_start,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :coverage_end,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :effectuation_status,  Types::String.meta(omittable: false)
        attribute :insurance_line_code,  Types::String.meta(omittable: false)
        attribute :coverage_household,  Types::Array.of(AcaEntities::Cms::Pbp::SbmiEnrollee).optional.meta(omittable: true)
        attribute :financial_loops,  Types::Array.of(AcaEntities::Cms::Pbp::FinancialInformation).optional.meta(omittable: true)
      end
    end
  end
end