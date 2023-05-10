# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/applicant'

module AcaEntities
  module Atp
    module Functions
      # applicants builder
      class ApplicantBuilder
        def call(cache)
          applicants_hash = cache.resolve('family.magi_medicaid_applications.applicants').item
          applicants_hash.each_with_object([]) do |applicant_hash, collector|
            applicant = applicant_hash[1]
            next unless applicant[:is_applying_coverage]

            enrolled_benefits = applicant[:benefits].select {|benefit| benefit[:status] == "is_enrolled" }
            enrolled_esi_benefits = enrolled_benefits.select {|benefit|  benefit[:kind] == "employer_sponsored_insurance" }
            enrolled_non_esi_benfits = enrolled_benefits.reject {|benefit| benefit[:kind] == "employer_sponsored_insurance" }

            eligible_benefits = applicant[:benefits].select {|benefit| benefit[:status] == "is_eligible" }
            eligible_esi_benefits = eligible_benefits.select {|benefit| benefit[:kind] == "employer_sponsored_insurance" }
            eligible_non_esi_benefits = eligible_benefits.reject {|benefit| benefit[:kind] == "employer_sponsored_insurance" }

            enrolled_non_esi_indicator = enrolled_non_esi_indicator(enrolled_non_esi_benfits)

            esi_coverage_indicators = [{
              enrolled_indicator: enrolled_esi_benefits.present?,
              eligible_indicator: eligible_esi_benefits.present?,
              eligibility_unknown_indicator: !(enrolled_esi_benefits.present? || eligible_esi_benefits.present?)
            }]

            non_esi_policies = get_non_esi_policies(eligible_non_esi_benefits)

            insurance_applicant = AcaEntities::Atp::Transformers::Aces::Applicant.transform(applicant)
            insurance_applicant.merge!(enrolled_non_esi_indicator, esi_associations: esi_coverage_indicators, non_esi_policies: non_esi_policies)
            collector << insurance_applicant
          end
        end

        def enrolled_non_esi_indicator(enrolled_non_esi_benfits)
          if enrolled_non_esi_benfits.present?
            { non_esi_coverage_indicators: [true] }
          else
            { non_esi_coverage_indicators: [false] }
          end
        end

        def get_non_esi_policies(eligible_non_esi_benefits)
          if eligible_non_esi_benefits
            eligible_non_esi_benefits.collect do |benefit|
              kind = benefit[:kind].present? ? AcaEntities::Atp::Types::InsuranceKindsOutbound[benefit[:kind]] : nil
              start_on = benefit[:start_on].present? ? Date.parse(benefit[:start_on]) : nil
              end_on = benefit[:end_on].present? ? Date.parse(benefit[:end_on]) : nil
              {
                source_code: kind,
                applied_effective_date_range: { start_date: { date: start_on }, end_date: { date: end_on } }
              }
            end.compact
          else
            []
          end
        end

      end
    end
  end
end
