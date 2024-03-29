# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A data type for an agreement by an issuer to provide coverage under an insurance plan to a set of members who subscribe as a unit.
          class EsiAssociation
            include HappyMapper

            tag 'InsuranceApplicantESIAssociation'
            namespace 'hix-ee'

            # True if an applicant is eligible for an employer sponsored insurance (ESI) plan; false otherwise.
            element :eligible_indicator, Boolean, tag: "InsuranceApplicantESIEligibleIndicator", namespace: "hix-ee"

            # True if an applicant is enrolled in an employer sponsored insurance (ESI) plan; false otherwise.
            element :enrolled_indicator, Boolean, tag: "InsuranceApplicantESIEnrolledIndicator", namespace: "hix-ee"

            # A date range an insurance applicant plans for coverage to be effective under an employer sponsored insurance (ESI) plan.
            has_many :planned_coverage_date_ranges, InsuranceApplicantEsiPlannedCoverageDateRange

            # True if it is unknown whether an applicant is eligible for an employer sponsored insurance (ESI) plan; false otherwise.
            element :eligibility_unknown_indicator, Boolean, tag: "InsuranceApplicantESIEligibilityUnknownIndicator", namespace: "hix-ee"

            # A reference to an employer sponsored insurance (ESI) arrangement.
            element :ref, EsiReference

            def self.domain_to_mapper(esi_association)
              mapper = self.new
              mapper.eligible_indicator = esi_association.eligible_indicator
              mapper.enrolled_indicator = esi_association.enrolled_indicator
              mapper.planned_coverage_date_ranges =
                InsuranceApplicantEsiPlannedCoverageDateRange.domain_to_mapper(esi_association.planned_coverage_date_ranges)
              mapper.eligibility_unknown_indicator = esi_association.eligibility_unknown_indicator
              # mapper.ref = esi_association&.ref
              mapper
            end

            def to_hash
              {
                eligible_indicator: eligible_indicator,
                enrolled_indicator: enrolled_indicator,
                planned_coverage_date_ranges: planned_coverage_date_ranges.map(&:to_hash),
                eligibility_unknown_indicator: eligibility_unknown_indicator,
                ref: ref
              }
            end
          end
        end
      end
    end
  end
end