# frozen_string_literal: true

# rubocop:disable  Lint/UnreachableCode, Metrics/MethodLength
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

      BenefitsMapping = {
        "INDIVIDUAL_INSURANCE" => 'private_individual_and_family_coverage',
        "MEDICAID" => 'medicaid',
        "MEDICARE" => 'medicare',
        "TRICARE" => 'tricare',
        "VETERAN_HEALTH_PROGRAM" => 'veterans_administration_health_benefits',
        "EMPLOYER_SPONSORED" => 'employer_sponsored_insurance',
        "CHIP" => 'child_health_insurance_plan'
        # "PEACE_CORPS" => 'peace_corps_health_benefits',
        # "OTHER_FULL_BENEFIT_COVERAGE" => 'other_full_benefit_coverage',
        # "OTHER_LIMITED_BENEFIT_COVERAGE" => 'OTHER_LIMITED_BENEFIT_COVERAGE'
      }.freeze

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
            kind: BenefitsMapping[enrolled_coverage[:insuranceMarketType]],
            status: 'is_eligible',
            # insurance_kind:  BenefitsMapping[enrolled_coverage[:insuranceMarketType]],
            start_on: Date.parse('2021-01-01'), # default value
            end_on: nil
          }
        end
        result
      end

      def offered_esc_hash
        return [] if @insurance_coverage_hash.nil?
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]

        @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          # if offered for employee sponsored coverage(esc) is set to true then proceed to next step
          next unless @insurance_coverage_hash[:offeredEmployeeCoverage] && !esc[:escEnrolledIndicator]
          begin
            result << AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_eligible",
                                                                                  phone: emp_phone(esc)))
          rescue StandardError => e
            puts "error in benefits_esc_hash #{e}"
          end
          result
        end
      end

      def offered_hra_hash
        if @insurance_coverage_hash.nil? || (!@insurance_coverage_hash[:offeredIchraIndicator] && @insurance_coverage_hash[:enrolledInIchraIndicator])
          return []
        end

        return [] unless @insurance_coverage_hash[:hraOffers]
        @insurance_coverage_hash[:hraOffers].each_with_object([]) do |hra, collect|
          next unless hra[:employer]
          phone = emp_phone(hra)
          collect << {
            employee_cost: "0.0", # default value
            kind: "health_reimbursement_arrangement",
            status: "is_eligible",
            employer: {
              employer_name: hra[:employer][:name], # default value
              employer_id: "123456789" # default value
            },
            is_esi_waiting_period: false, # default value
            is_esi_mec_met: "no", # default value
            esi_covered: "self", # default value
            start_on: Date.parse("2021-01-01"), # default value
            end_on: nil, # default value
            employee_cost_frequency: "Monthly", # default value
            employer_address: {
              address_1: "21313312", # default value
              address_2: "", # default value
              address_3: "", # default value
              county: "", # default value
              country_name: "", # default value
              kind: "work", # default value
              city: "was", # default value
              state: "DC", # default value
              zip: "31232" # default value
            },
            employer_phone: {
              kind: 'work', # default value
              country_code: '',
              area_code: phone[0..2],
              number: phone[3..9],
              extension: '',
              full_phone_number: phone
            }
          }
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_hash
        return [] if @insurance_coverage_hash.nil?

        result = []
        @insurance_coverage_hash[:enrolledCoverages].each do |enrolled_coverage|
          next if enrolled_coverage[:insuranceMarketType] == 'NONE'
          next unless BenefitsMapping[enrolled_coverage[:insuranceMarketType]]

          result << {
            kind: BenefitsMapping[enrolled_coverage[:insuranceMarketType]],
            status: 'is_enrolled',
            # insurance_kind:  BenefitsMapping[enrolled_coverage[:insuranceMarketType]],
            start_on: Date.parse('2021-01-01'), # default value
            end_on: nil
          }
        end
        result
      end

      def enrolled_hra_hash
        if @insurance_coverage_hash.nil? || (!@insurance_coverage_hash[:enrolledInIchraIndicator] && @insurance_coverage_hash[:offeredIchraIndicator])
          return []
        end

        return [] unless @insurance_coverage_hash[:hraOffers]
        @insurance_coverage_hash[:hraOffers].each_with_object([]) do |(_k, hra), collect|

          next unless hra[:employer]
          phone = emp_phone(hra)
          collect << {
            employee_cost: "0.0", # default value
            kind: "health_reimbursement_arrangement",
            status: "is_enrolled",
            employer: {
              employer_name: hra[:employer][:name], # default value
              employer_id: "123456789" # default value
            },
            is_esi_waiting_period: false, # default value
            is_esi_mec_met: "no", # default value
            esi_covered: "self", # default value
            start_on: Date.parse("2021-01-01"), # default value
            end_on: nil, # default value
            employee_cost_frequency: "Monthly", # default value
            employer_address: {
              address_1: "21313312", # default value
              address_2: "", # default value
              address_3: "", # default value
              county: "", # default value
              country_name: "", # default value
              kind: "work", # default value
              city: "was", # default value
              state: "DC", # default value
              zip: "31232" # default value
            },
            employer_phone: {
              kind: 'work', # default value
              country_code: '',
              area_code: phone[0..2],
              number: phone[3..9],
              extension: '',
              full_phone_number: phone
            }
          }
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_esc_hash
        return [] if @insurance_coverage_hash.nil?
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]
        @insurance_coverage_hash[:employerSponsoredCoverageOffers].each_with_object([]) do |(_k, esc), result|
          # if enrolled in employee sponsored coverage(esc) is set to true then proceed to next step
          next unless esc[:escEnrolledIndicator] && !@insurance_coverage_hash[:offeredEmployeeCoverage]
          begin
            result << AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_enrolled",
                                                                                  phone: emp_phone(esc)))
          rescue StandardError => e
            puts "error in benefits_esc_hash #{e}"
          end
          result
        end
      end

      def emp_phone(esc)
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
# rubocop:enable  Lint/UnreachableCode, Metrics/MethodLength
