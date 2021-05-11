# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for ProductEligibilityDetermination.
    class ProductEligibilityDetermination < Dry::Struct

      attribute :is_ia_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_medicaid_chip_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_non_magi_medicaid_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_totally_ineligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_without_assistance, Types::Bool.optional.meta(omittable: true)
      attribute :is_magi_medicaid, Types::Bool.optional.meta(omittable: true)

      attribute :magi_medicaid_monthly_household_income, Types::Float.optional.meta(omittable: true)
      attribute :medicaid_household_size, Types::Integer.optional.meta(omittable: true)
      attribute :magi_medicaid_monthly_income_limit, Types::Float.optional.meta(omittable: true)
      attribute :magi_as_percentage_of_fpl, Types::Float.optional.meta(omittable: true)
      attribute :magi_medicaid_category, Types::MagiMedicaidCategoryType

      attribute :magi_medicaid_ineligibility_reasons, Types::Array.of(Types::String).optional.meta(omittable: true)
      # Is the person potentially eligible for non-MAGI reasons?
      attribute :is_eligible_for_non_magi_reasons, Types::Bool.optional.meta(omittable: true)
      attribute :chip_ineligibility_reasons, Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :magi_medicaid_category_threshold, Types::Float.optional.meta(omittable: true)
      attribute :medicaid_chip_category, Types::String.optional.meta(omittable: true)
      attribute :medicaid_chip_category_threshold, Types::Float.optional.meta(omittable: true)

      attribute :category_determinations, Types::Array.of(CategoryDetermination).optional.meta(omittable: true)

    end
  end
end
