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

        eligible_medicaid_cubcare_hash.merge(
          has_eligibility_changed: medicaid_hash[:informationChangeSinceMedicaidEndedIndicator] && medicaid_hash[:medicaidEndIndicator],
          has_household_income_changed: medicaid_hash[:informationChangeSinceMedicaidEndedIndicator],
          person_coverage_end_on: medicaid_hash[:medicaidEndDate]
        )
      end

      # Was this person found not eligible for MaineCare (Medicaid) or CubCare (Children's Health Insurance Program) within the last 90 days? *
      def eligible_medicaid_cubcare_hash
        if medicaid_hash[:medicaidDeniedIndicator]
          { has_eligible_medicaid_cubcare: medicaid_hash[:medicaidDeniedIndicator], medicaid_cubcare_due_on: medicaid_hash[:medicaidDeniedDate] }
        else
          { has_eligible_medicaid_cubcare: medicaid_hash[:medicaidDeniedIndicator] }
        end
      end
    end
  end
end

