# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for TaxHousehold.
    class TaxHousehold < Dry::Struct

      attribute :max_aptc, Types::Money.optional.meta(omittable: true)
      attribute :hbx_id, Types::String

      # ['UnDetermined', 'True', 'False']
      attribute :is_insurance_assistance_eligible, Types::IaEligibilityKind.optional.meta(omittable: true)
      attribute :tax_household_members, Types::Array.of(TaxHouseholdMember).meta(omittable: false)

      # aptc_csr_annual_household_income
      attribute :annual_tax_household_income, Types::Money.optional.meta(omittable: true)
      attribute :csr_annual_income_limit, Types::Money.optional.meta(omittable: true)
      attribute :is_ifsv_eligible, Types::Bool.optional.meta(omittable: true)

      # The effective on date of the tax household
      attribute :effective_on, Types::Date.optional.meta(omittable: true)
      attribute :determined_on, Types::Date.optional.meta(omittable: true)

      # Yearly Expected Contribution
      attribute :yearly_expected_contribution, ::AcaEntities::Types::Money.optional.meta(omittable: true)

      def aptc_csr_eligible?
        tax_household_members.any?(&:aptc_csr_eligible?)
      end

      def aptc_csr_eligible_members
        tax_household_members.select(&:aptc_csr_eligible?)
      end

      def aptc_members_aged_19_or_above(effective_date)
        tax_household_members.select do |thhm|
          thhm.aptc_csr_eligible? && thhm.age_on(effective_date) >= 19
        end
      end

      def aptc_members_aged_below_19(effective_date)
        tax_household_members.select do |thhm|
          thhm.aptc_csr_eligible? && thhm.age_on(effective_date) < 19
        end
      end
    end
  end
end
