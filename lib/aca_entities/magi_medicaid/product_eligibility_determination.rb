# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for ProductEligibilityDetermination.
    class ProductEligibilityDetermination < Dry::Struct

      attribute :is_ia_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_medicaid_chip_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_totally_ineligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_magi_medicaid, Types::Bool.optional.meta(omittable: true)
      attribute :is_uqhp_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_csr_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :csr, Types::CsrKind.optional.meta(omittable: true)

      attribute :is_non_magi_medicaid_eligible, Types::Bool.optional.meta(omittable: true)
      attribute :is_without_assistance, Types::Bool.optional.meta(omittable: true)

      attribute :magi_medicaid_monthly_household_income, Types::Money.optional.meta(omittable: true)
      attribute :medicaid_household_size, Types::Integer.optional.meta(omittable: true)
      attribute :magi_medicaid_monthly_income_limit, Types::Money.optional.meta(omittable: true)
      attribute :magi_as_percentage_of_fpl, Types::Money.optional.meta(omittable: true)
      attribute :magi_medicaid_category, Types::MagiMedicaidCategoryType.optional.meta(omittable: true)

      attribute :magi_medicaid_ineligibility_reasons, Types::Array.of(Types::String).optional.meta(omittable: true)
      # Is the person potentially eligible for non-MAGI reasons?
      attribute :is_eligible_for_non_magi_reasons, Types::Bool.optional.meta(omittable: true)
      attribute :chip_ineligibility_reasons, Types::Array.of(Types::String).optional.meta(omittable: true)
      attribute :magi_medicaid_category_threshold, Types::Money.optional.meta(omittable: true)
      attribute :medicaid_chip_category, Types::String.optional.meta(omittable: true)
      attribute :medicaid_chip_category_threshold, Types::Money.optional.meta(omittable: true)

      attribute :category_determinations, Types::Array.of(CategoryDetermination).optional.meta(omittable: true)

      # MagiMedicaid Category Determination for type Income
      def medicaid_cd_for_income
        return nil unless category_determinations
        category_determinations.detect do |cat_det|
          cat_det.category == 'Income Medicaid Eligible'
        end
      end

      # MedicaidChip Category Determination for type Income
      def chip_cd_for_income
        return nil unless category_determinations
        category_determinations.detect do |cat_det|
          cat_det.category == 'Income CHIP Eligible'
        end
      end

      # MagiMedicaid Category Determination for type Citizen Or Immigrant
      def medicaid_cd_for_citizen_or_immigrant
        return nil unless category_determinations
        category_determinations.detect do |cat_det|
          cat_det.category == 'Medicaid Citizen Or Immigrant'
        end
      end

      # MedicaidChip Category Determination for type Citizen Or Immigrant
      def chip_cd_for_citizen_or_immigrant
        return nil unless category_determinations
        category_determinations.detect do |cat_det|
          cat_det.category == 'CHIP Citizen Or Immigrant'
        end
      end
    end
  end
end
