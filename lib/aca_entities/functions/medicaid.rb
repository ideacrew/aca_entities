# frozen_string_literal: true

module AcaEntities
  module Functions
    # build IAP income
    class Medicaid
      attr_accessor :medicaid_hash

      # Did this person have MaineCare (Medicaid) or CubCare (Children's Health Insurance Program) that will end soon or that recently ended because of a change in eligibility? *
      # # What is the last day of this person’s MaineCare (Medicaid) or CubCare (CHIP) coverage? *
      def call(cache, m_identifier = nil)
        @medicaid_hash = cache.find(Regexp.new("attestations.members.#{m_identifier}.medicaid"))&.first&.item

        { medicaid_and_chip: eligible_medicaid_cubcare_hash.merge(
          ended_as_change_in_eligibility: medicaid_hash[:informationChangeSinceMedicaidEndedIndicator] && medicaid_hash[:medicaidEndIndicator],
          hh_income_or_size_changed: medicaid_hash[:informationChangeSinceMedicaidEndedIndicator],
          medicaid_or_chip_coverage_end_date: medicaid_hash[:medicaidEndDate]
        ) }

        # # Was this person found not eligible for MaineCare (Medicaid) or
        # # CubCare (Children's Health Insurance Program) based on their immigration status since [current year minus 5 years]?
        # attribute :ineligible_due_to_immigration_in_last_5_years, Types::Bool.optional.meta(omittable: true)

        # # Has this person's immigration status changed since they were not found eligible
        # # for MaineCare (Medicaid) or CubCare (Children's Health Insurance Program)?
        # attribute :immigration_status_changed_since_ineligibility, Types::Bool.optional.meta(omittable: true)
      end

      # Was this person found not eligible for MaineCare (Medicaid) or CubCare (Children's Health Insurance Program) within the last 90 days? *
      def eligible_medicaid_cubcare_hash
        if medicaid_hash[:medicaidDeniedIndicator]
          { not_eligible_in_last_90_days: medicaid_hash[:medicaidDeniedIndicator], denied_on: medicaid_hash[:medicaidDeniedDate] }
        else
          { not_eligible_in_last_90_days: medicaid_hash[:medicaidDeniedIndicator] }
        end
      end
    end
  end
end

