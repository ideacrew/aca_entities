# frozen_string_literal: true

module AcaEntities
  module Households
    class Household < Dry::Struct

      attribute :start_date,              Types::Date.meta(omittable: false)
      attribute :end_date,                Types::Date.optional.meta(omittable: true)
      attribute :is_active,               Types::Bool.meta(omittable: false)
      attribute :irs_group,               AcaEntities::Groups::IrsGroup.optional.meta(omittable: true)
      attribute :tax_households,          Types::Strict::Array.of(AcaEntities::Households::TaxHousehold).optional.meta(omittable: true)
      attribute :coverage_households,     Types::Strict::Array.of(AcaEntities::Households::CoverageHousehold).meta(omittable: false)
      attribute :hbx_enrollments,         Types::Strict::Array.of(AcaEntities::Enrollments::HbxEnrollment).optional.meta(omittable: false)
    end
  end
end