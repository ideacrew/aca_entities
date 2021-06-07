# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for MAGI Medicaid MedicaidAndChip.
    class MedicaidAndChip < Dry::Struct
      # @!attribute [r] not_eligible_in_last_90_days
      # Was this person found not eligible for MaineCare (Medicaid) or
      # CubCare (Children's Health Insurance Program) within the last 90 days?
      # @return [Bool]
      attribute :not_eligible_in_last_90_days, Types::Bool

      # @!attribute [r] denied_on
      # When was this person denied MaineCare (Medicaid) or CubCare (Children's Health Insurance Program)?
      # @return [Date]
      attribute :denied_on, Types::Date.optional.meta(omittable: true)

      # @!attribute [r] ended_as_change_in_eligibility
      # Did this person have MaineCare (Medicaid) or CubCare (Children's Health Insurance Program)
      # that will end soon or that recently ended because of a change in eligibility?
      # @return [Bool]
      attribute :ended_as_change_in_eligibility, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] hh_income_or_size_changed
      # Has this person's household income or household size changed since they were told their coverage was ending?
      # @return [Bool]
      attribute :hh_income_or_size_changed, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] medicaid_or_chip_coverage_end_date
      # What's the last day of this person's Medicaid or CHIP coverage?
      # @return [Bool]
      attribute :medicaid_or_chip_coverage_end_date, Types::Date.optional.meta(omittable: true)

      # @!attribute [r] ineligible_due_to_immigration_in_last_5_years
      # Was this person found not eligible for MaineCare (Medicaid) or
      # CubCare (Children's Health Insurance Program) based on their immigration status since [current year minus 5 years]?
      # @return [Bool]
      attribute :ineligible_due_to_immigration_in_last_5_years, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] immigration_status_changed_since_ineligibility
      # Has this person's immigration status changed since they were not found eligible
      # for MaineCare (Medicaid) or CubCare (Children's Health Insurance Program)?
      # @return [Bool]
      attribute :immigration_status_changed_since_ineligibility, Types::Bool.optional.meta(omittable: true)
    end
  end
end
