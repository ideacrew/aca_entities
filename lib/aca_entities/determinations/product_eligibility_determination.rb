# frozen_string_literal: true

module AcaEntities
  module Determinations
    class ProductEligibilityDetermination < Dry::Struct

      attribute :is_ia_eligible,                          Types::Bool.optional.meta(omittable: false)
      attribute :is_medicaid_chip_eligible,               Types::Bool.optional.meta(omittable: false)
      attribute :is_non_magi_medicaid_eligible,           Types::Bool.optional.meta(omittable: false)
      attribute :is_totally_ineligible,                   Types::Bool.optional.meta(omittable: false)
      attribute :is_without_assistance,                   Types::Bool.optional.meta(omittable: false)
      attribute :is_magi_medicaid,                        Types::Bool.optional.meta(omittable: true)
      attribute :magi_medicaid_monthly_household_income,  Types::Float.optional.meta(omittable: false)
      attribute :medicaid_household_size,                 Types::Integer.optional.meta(omittable: false)
      attribute :magi_medicaid_monthly_income_limit,      Types::Float.optional.meta(omittable: false)
      attribute :magi_as_percentage_of_fpl,               Types::Float.optional.meta(omittable: false)
      attribute :magi_medicaid_category,                  Types::MagiMedicaidCategoryType
    end
  end
end