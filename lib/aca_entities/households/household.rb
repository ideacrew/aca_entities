# frozen_string_literal: true

module AcaEntities
  module Households
    class Household < Dry::Struct

      attribute :start_date,              Types::Date.meta(omittable: false)
      attribute :end_date,                Types::Date.optional.meta(omittable: true)
      attribute :submitted_at,            Types::Date.optional.meta(omittable: true)
      attribute :is_active,               Types::Bool.meta(omittable: false)
      attribute :irs_group,               AcaEntities::Groups::IrsGroup.optional.meta(omittable: true)
      attribute :tax_households,          Types::Strict::Array.of(AcaEntities::Households::TaxHousehold).optional.meta(omittable: true)
      attribute :coverage_households,     Types::Strict::Array.of(AcaEntities::Households::CoverageHousehold).optional.meta(omittable: false)
      attribute :insurance_agreements,
                Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::InsuranceAgreement).optional.meta(omittable: true)
      attribute :hbx_enrollments,         Types::Strict::Array.of(AcaEntities::Enrollments::HbxEnrollment).optional.meta(omittable: true)
    end
  end
end