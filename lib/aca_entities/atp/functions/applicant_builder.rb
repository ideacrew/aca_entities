# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/applicant'

module AcaEntities
  module Atp
    module Functions
      # applicants builder
      class ApplicantBuilder
        def call(cache) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          applicants_hash = cache.resolve('family.magi_medicaid_applications.applicants').item
          applicants_hash.each_with_object([]) do |applicant_hash, collector|
            applicant = applicant_hash[1]
            next unless applicant[:is_applying_coverage]

            enrolled_benefits = applicant[:benefits].select {|benefit| benefit[:status] == "is_enrolled" }
            eligible_benefits = applicant[:benefits].select {|benefit| benefit[:status] == "is_eligible" }

            non_esi_coverage_enrolled_array = enrolled_benefits.reject {|benefit| benefit[:kind] == "employer_sponsored_insurance" }
            non_esi_coverage_eligible_array = eligible_benefits.reject {|benefit| benefit[:kind] == "employer_sponsored_insurance" }
            esi_coverage_enrolled = enrolled_benefits.select {|benefit|  benefit[:kind] == "employer_sponsored_insurance" }
            esi_coverage_eligible = eligible_benefits.select {|benefit| benefit[:kind] == "employer_sponsored_insurance" }

            non_esi_coverage_indicators = if non_esi_coverage_enrolled_array
                                            { non_esi_coverage_indicators: [true] }
                                          else
                                            { non_esi_coverage_indicators: [false] }
                                          end

            non_esi_policies = if non_esi_coverage_eligible_array
                                 non_esi_coverage_eligible_array.collect do |benefit|
                                   source_code = AcaEntities::Atp::Types::InsuranceKinds.invert[benefit[:kind]]
                                   { source_code: source_code } if source_code
                                 end.compact
                               else
                                 []
                               end

            esi_coverage_indicators = [{ enrolled_indicator: esi_coverage_enrolled.present?,
                                         eligible_indicator: esi_coverage_eligible.present?,
                                         eligibility_unknown_indicator: !(esi_coverage_enrolled.present? || esi_coverage_eligible.present?) }]
            insurance_applicant = AcaEntities::Atp::Transformers::Aces::Applicant.transform(applicant)
            insurance_applicant.merge!(non_esi_coverage_indicators, esi_associations: esi_coverage_indicators, non_esi_policies: non_esi_policies)
            collector << insurance_applicant
          end
        end
      end
    end
  end
end
