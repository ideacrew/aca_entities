# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/applicant'

module AcaEntities
  module Atp
    module Functions
      # insurance_applicant builder
      class ApplicantBuilder
        def call(cache)
          applicants_hash = cache.resolve('family.magi_medicaid_applications.applicants').item
          applicants_hash.each_with_object([]) do |applicant_hash, collector|
            applicant = applicant_hash[1]
            next unless applicant[:is_applying_coverage]

            esi_benefits = applicant[:benefits].select {|benefit| benefit[:kind] == "employer_sponsored_insurance" }

            non_esi_benefits = applicant[:benefits].reject {|benefit| benefit[:kind] == "employer_sponsored_insurance" }
            enrolled_non_esi_benfits = non_esi_benefits.select {|benefit| benefit[:status] == "is_enrolled" }

            enrolled_non_esi_indicator = get_enrolled_non_esi_indicator(enrolled_non_esi_benfits)
            esi_coverage_indicators = get_esi_coverage_indicators(esi_benefits)
            non_esi_policies = get_non_esi_policies(enrolled_non_esi_benfits)
            referral_activity_hash = referral_activity(applicant)

            insurance_applicant = AcaEntities::Atp::Transformers::Aces::Applicant.transform(applicant)

            insurance_applicant.merge!(enrolled_non_esi_indicator, referral_activity: referral_activity_hash,
                                                                   esi_associations: esi_coverage_indicators, non_esi_policies: non_esi_policies)
            collector << insurance_applicant
          end
        end

        def referral_activity(applicant)
          referral_activity_values = {
            activity_id: { identification_id: ["SBM", DateTime.now.strftime("%Y%m%d%H%M%S"), "pe#{applicant[:person_hbx_id]}"&.slice(-3..-1)].join },
            activity_date: { date_time: DateTime.now },
            sender_reference: { :ref => "Sender" }, # TODO
            receiver_reference: { :ref => "medicaidReceiver" }, # TODO
            status: { :status_code => "Initiated" } # TODO
          }
          referral_activity_values[:reason_code] = applicant[:reason_code] unless applicant[:reason_code].blank?
          unless applicant[:additional_reason_codes].nil?
            referral_activity_values[:additional_reason_codes] = extract_additional_reason_codes(applicant[:additional_reason_codes])
          end
          referral_activity_values
        end

        # I don't know why the transformer 'double-nests' my array value,
        # but I'm not going to fix it at the risk of damaging overall behaviour
        def extract_additional_reason_codes(reason_codes_value)
          if reason_codes_value.is_a?(Array) && reason_codes_value.first.is_a?(Hash)
            reason_codes_value.first.values.first
          else
            reason_codes_value
          end
        end

        def get_enrolled_non_esi_indicator(enrolled_non_esi_benfits)
          if enrolled_non_esi_benfits.present?
            { non_esi_coverage_indicators: [true] }
          else
            { non_esi_coverage_indicators: [false] }
          end
        end

        def get_esi_coverage_indicators(esi_benefits)
          if esi_benefits
            esi_benefits.collect do |benefit|
              is_enrolled = benefit[:status] == "is_enrolled"
              is_eligible = benefit[:status] == "is_eligible"
              start_on = benefit[:start_on].present? ? Date.parse(benefit[:start_on]) : nil
              end_on = benefit[:end_on].present? ? Date.parse(benefit[:end_on]) : nil
              {
                enrolled_indicator: is_enrolled,
                eligible_indicator: is_eligible,
                planned_coverage_date_ranges: { start_date: { date: start_on }, end_date: { date: end_on } },
                eligibility_unknown_indicator: !(is_enrolled || is_eligible)
              }
            end.compact
          else
            []
          end
        end

        def get_non_esi_policies(non_esi_benefits)
          if non_esi_benefits
            non_esi_benefits.collect do |benefit|
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
