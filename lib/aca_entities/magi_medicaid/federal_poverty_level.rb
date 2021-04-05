# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for MAGI Medicaid Federal Povery Level.
    # Financial eligibility guildelines for Medicaid program issued each year
    # in the Federal Register by the Department of Health and Human Services
    # (HHS). HHS issues poverty guidelines in late January of each year.
    #
    # Some programs make them effective on date of publication, others at a
    # later # date. For example, the 2013 poverty guidelines were issued in
    # January 2013, calculated from the calendar year 2011 thresholds issued in
    # September 2012, updated to reflect the price level of calendar year 2012.
    # Therefore, the 2013 poverty guidelines are approximately equal to the
    # poverty thresholds for 2012 (for most family sizes).

    class FederalPovertyLevel < Dry::Struct
      # @!attribute [r] state_code
      # The two-character code of the US State or Territory associated with
      # this record
      # @return [String]
      attribute :state_code, Types::String.meta(omittable: false)

      # @!attribute [r] household_size
      # The number of persons in the family or household
      # @return [Integer]
      attribute :household_size, Types::Integer.meta(omittable: false)

      # @!attribute [r] medicaid_year
      # The calendar year for the {annual_poverty_guideline}
      # @return [Integer]
      attribute :medicaid_year, Types::Integer.meta(omittable: false)

      # @!attribute [r] annual_poverty_guideline
      # The annual income figure below which the family/household
      # is considered extremely poor
      # @return [BigDecimal]
      attribute :annual_poverty_guideline,
                AcaEntities::Types::Money.meta(omittable: false)

      # @!attribute [r] annual_per_person_amount
      # The amount above the {annual_poverty_guideline} to add
      # for each additional person in the household
      # @return [BigDecimal]
      attribute :annual_per_person_amount,
                AcaEntities::Types::Money.meta(omittable: false)

      # @!attribute [r] monthly_poverty_guideline
      # The monthly income figure below which the family/household
      # is considered extremely poor
      # @return [BigDecimal]
      attribute :monthly_poverty_guideline,
                AcaEntities::Types::Money.meta(omittable: false)

      # @!attribute [r] monthly_per_person_amount
      # The amount above the {monthly_poverty_guideline} to add
      # for each additional person in the household
      # @return [BigDecimal]
      attribute :monthly_per_person_amount,
                AcaEntities::Types::Money.meta(omittable: false)

      # @!attribute [r] aptc_effective_start_on
      # The date on which this guideline becomes active
      # @return [Date]
      attribute :aptc_effective_start_on, Types::Date.meta(omittable: false)

      # @!attribute [r] aptc_effective_end_on
      # The last day on which this guideline is active
      # @return [Date]
      attribute :aptc_effective_end_on, Types::Date.meta(omittable: false)
    end
  end
end
