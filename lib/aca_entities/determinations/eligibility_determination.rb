# frozen_string_literal: true

module AcaEntities
  module Determinations
    class EligibilityDetermination < Dry::Struct
      attribute :e_pdc_id,                            Types::String.optional.meta(omittable: false)
      attribute :benchmark_plan,                      AcaEntities::Products::ProductReference.optional.meta(omittable: false)
      attribute :max_aptc,                            AcaEntities::Curreny.meta(omittable: false)
      attribute :premium_credit_strategy_kind,        Types::String.optional.meta(omittable: false)
      attribute :csr_percent_as_integer,              Types::String.optional.meta(omittable: false)
      attribute :csr_eligibility_kind,                Types::String.optional.meta(omittable: false)
      attribute :aptc_csr_annual_household_income,    AcaEntities::Curreny.meta(omittable: false)
      attribute :aptc_annual_income_limit,            AcaEntities::Curreny.meta(omittable: false)
      attribute :csr_annual_income_limit,             AcaEntities::Curreny.meta(omittable: false)
      attribute :determined_at,                       Types::Date.optional.meta(omittable: false)
      attribute :source,                              Types::String.optional.meta(omittable: false)
    end
  end
end