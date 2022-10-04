# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdGroup < Dry::Struct

      attribute :hbx_id,                 Types::String.meta(omittable: false)
      attribute :assistance_year,        Types::Integer.meta(omittable: false)
      attribute :start_on,               Types::Date.meta(omittable: false)
      attribute :end_on,                 Types::Date.meta(omittable: true)
      attribute :source,                 ::AcaEntities::Types::EligibilityDeterminationSourceKinds.optional.meta(omittable: true)
      attribute :application_hbx_id,     Types::String.optional.meta(omittable: true)
      attribute :tax_households,         Types::Strict::Array.of(AcaEntities::Households::TaxHousehold).optional.meta(omittable: true)
      attribute :household_group_benchmark_ehb_premium, Types::Money.optional.meta(omittable: true)
    end
  end
end