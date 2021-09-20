# frozen_string_literal: true

# rubocop:disable  Lint/UnreachableCode
module AcaEntities
  module Functions
    # build IAP income
    class Benefit

      # MCR payload kinds
      # INDIVIDUAL_INSURANCE
      # NONE
      # MARKETPLACE_COVERAGE
      # MEDICAID
      # CHIP
      # EMPLOYER_SPONSORED
      # MEDICARE
      # TRICARE
      # VETERAN_HEALTH_PROGRAM

      # enroll
      # INSURANCE_KINDS = %w[
      #   private_individual_and_family_coverage
      #   acf_refugee_medical_assistance
      #   americorps_health_benefits
      #   child_health_insurance_plan
      #   medicaid
      #   medicare
      #   medicare_advantage
      #   medicare_part_b
      #   state_supplementary_payment
      #   tricare
      #   veterans_benefits
      #   naf_health_benefit_program
      #   health_care_for_peace_corp_volunteers
      #   department_of_defense_non_appropriated_health_benefits
      #   cobra
      #   employer_sponsored_insurance
      #   self_funded_student_health_coverage
      #   foreign_government_health_coverage
      #   private_health_insurance_plan
      #   coverage_obtained_through_another_exchange
      #   coverage_under_the_state_health_benefits_risk_pool
      #   veterans_administration_health_benefits
      #   peace_corps_health_benefits
      #   health_reimbursement_arrangement
      #   retiree_health_benefits
      #   other_full_benefit_coverage
      #   other_limited_benefit_coverage
      #   ].freeze

      def call(cache, m_identifier = nil)
        @insurance_coverage_hash = cache.find(Regexp.new("attestations.members.#{m_identifier}.insuranceCoverage"))&.first&.item
        return { benefits: [], has_enrolled_health_coverage: nil, has_eligible_health_coverage: nil } if @insurance_coverage_hash.nil?

        enrolled_health_coverage = [enrolled_hash, enrolled_hra_hash, enrolled_esc_hash].flatten.compact
        eligible_health_coverage = [eligible_hash, offered_hra_hash, offered_esc_hash].flatten.compact

        { has_enrolled_health_coverage: !enrolled_health_coverage.empty?,
          has_eligible_health_coverage: !eligible_health_coverage.empty?,
          benefits: enrolled_health_coverage + eligible_health_coverage }
      end

      # Does this person currently have access to health coverage or a Health Reimbursement Arrangement
      ## that they are not enrolled in (including through another person, like a spouse or parent)? *
      def eligible_hash
        result = []

        return []
        # TODO: refactor as per offered markets
        @medicaid_hash[:insuranceCoverage].each do |_eligible_coverage|
          next if enrolled_coverage[:insuranceMarketType] == 'NONE'

          result << {
            kind: Ffe::Types::BenefitsKindMapping[enrolled_coverage[:insuranceMarketType].to_sym],
            status: 'is_eligible',
            start_on: Date.parse('2021-01-01'), # default value
            end_on: nil
          }
        end
        result
      end

      def offered_esc_hash
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]

        @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          # if offered for employee sponsored coverage(esc) is set to true then proceed to next step
          next unless @insurance_coverage_hash[:offeredEmployeeCoverage] && !esc[:escEnrolledIndicator]
          esc_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_eligible",
                                                                                 phone: emp_phone(esc)))
          esc_hash[:employer].delete(:employer_phone) if esc_hash[:employer] && emp_phone(esc).blank?
          result << esc_hash
          result
        end
      end

      def offered_hra_hash
        return [] if !@insurance_coverage_hash[:offeredIchraIndicator] && @insurance_coverage_hash[:enrolledInIchraIndicator]
        return [] unless @insurance_coverage_hash[:hraOffers]
        @insurance_coverage_hash[:hraOffers].each_with_object([]) do |hra, collect|
          next unless hra[:employer]
          hra_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(hra.merge(kind: 'health_reimbursement_arrangement', :status => "is_eligible",
                                                                                 phone: emp_phone(hra)))
          hra_hash[:employer].delete(:employer_phone) if hra_hash[:employer] && emp_phone(hra).blank?
          collect << hra_hash
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_hash
        result = []
        @insurance_coverage_hash[:enrolledCoverages].each do |enrolled_coverage|
          next if enrolled_coverage[:insuranceMarketType] == 'NONE'
          next if enrolled_coverage[:insuranceMarketType] == 'EMPLOYER_SPONSORED'
          next unless Ffe::Types::BenefitsKindMapping[enrolled_coverage[:insuranceMarketType].to_sym]

          result << {
            kind: Ffe::Types::BenefitsKindMapping[enrolled_coverage[:insuranceMarketType].to_sym],
            status: 'is_enrolled',
            start_on: Date.parse('2021-01-01'), # default value
            end_on: nil
          }
        end
        result
      end

      def enrolled_hra_hash
        return [] if !@insurance_coverage_hash[:enrolledInIchraIndicator] && @insurance_coverage_hash[:offeredIchraIndicator]
        return [] unless @insurance_coverage_hash[:hraOffers]
        @insurance_coverage_hash[:hraOffers].each_with_object([]) do |(hra, _k), collect|
          next unless hra[:employer]
          hra_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(hra.merge(kind: 'health_reimbursement_arrangement', :status => "is_enrolled",
                                                                      phone: emp_phone(hra)))
          hra_hash[:employer].delete(:employer_phone) if hra_hash[:employer] && emp_phone(hra).blank?
          collect << hra_hash
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_esc_hash
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]
        @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          # if enrolled in employee sponsored coverage(esc) is set to true then proceed to next step
          next unless esc[:escEnrolledIndicator] && !@insurance_coverage_hash[:offeredEmployeeCoverage]
          esc_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_enrolled",
                                                                      phone: emp_phone(esc)))
          esc_hash[:employer].delete(:employer_phone) if esc_hash[:employer] && emp_phone(esc).blank?
          result << esc_hash
          result
        end
      end

      def emp_phone(esc)
        return "" if esc[:employer].nil?
        if !esc[:employer][:employerPhoneNumber].nil?
          esc[:employer][:employerPhoneNumber]
        elsif !esc[:employer][:contact].nil?
          esc[:employer][:contact][:phoneNumber]
        else
          ""
        end
      end
    end
  end
end
# rubocop:enable  Lint/UnreachableCode
