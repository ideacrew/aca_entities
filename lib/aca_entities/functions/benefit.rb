# frozen_string_literal: true

# rubocop:disable  Lint/UnreachableCode
module AcaEntities
  module Functions
    # build IAP income
    class Benefit
      # MCR payload kinds
      # insuranceCoverage#insuranceMarketType
      # INDIVIDUAL_INSURANCE
      # NONE
      # MARKETPLACE_COVERAGE
      # MEDICAID
      # CHIP
      # EMPLOYER_SPONSORED
      # MEDICARE
      # TRICARE
      # VETERAN_HEALTH_PROGRAM
      # PEACE_CORPS

      # ["enrolledCoverages", "offeredEmployeeCoverage", "enrolledInIchraIndicator",
      #  "offeredIchraIndicator", "employerSponsoredCoverageOffers", "hraOffers"]

      # keys
        # enrolledCoverages
        # [{"insuranceMarketType"=>"INDIVIDUAL_INSURANCE"},
        #  {"insuranceMarketType"=>"NONE"},
        #  {"insuranceMarketType"=>"MARKETPLACE_COVERAGE"},
        #  {"insuranceMarketType"=>"MEDICAID"},
        #  {"insuranceMarketType"=>"CHIP"},
        #  {"insuranceMarketType"=>"EMPLOYER_SPONSORED", "insurancePlanName"=>"bc/bs"},
        #  {"insuranceMarketType"=>"MEDICARE"},
        #  {"insuranceMarketType"=>"EMPLOYER_SPONSORED"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"1ED6-FN8-PJ68"},
        #  {"insuranceMarketType"=>"TRICARE"},
        #  {"insuranceMarketType"=>"VETERAN_HEALTH_PROGRAM"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"6DW3-AN5-VJ02"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"2P53-E15-DF90"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"4HY1A35FY17"},
        #  {"insuranceMarketType"=>"PEACE_CORPS"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"4CY4Y40NV64"},
        #  {"insuranceMarketType"=>"MARKETPLACE_COVERAGE",
        #   "insurancePolicyMemberId"=>"570w03088",
        #   "insurancePlanName"=>"anthem"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"5CJ5FF2KW63"},
        #  {"insuranceMarketType"=>"MEDICAID", "insurancePolicyMemberId"=>"75603073A"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"9617039443"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"4V21-MW9-JE94"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"Part A only"},
        #  {"insuranceMarketType"=>"MEDICARE", "insurancePolicyNumber"=>"3PT5VW25A53"},
        #  {"insuranceMarketType"=>"VETERAN_HEALTH_PROGRAM",
        #   "insurancePolicyMemberId"=>"7346 243 588",
        #   "insurancePolicyNumber"=>"80840"},
        #  {"insuranceMarketType"=>"MEDICARE",
        #   "insurancePolicyMemberId"=>"8RV4-TV4-QA94"}]

      # employerSponsoredCoverageOffers
        # ["cobraAvailableIndicator",
        #  "employerOffersMinValuePlan",
        #  "planToEnrollEscIndicator",
        #  "employerWillChangeLcsopPremiumIndicator",
        #  "employerWillNoLongerOfferLcsopIndicator",
        #  "escEnrolledIndicator",
        #  "doNotKnowLcsopPremiumIndicator",
        #  "lcsopPremium",
        #  "lcsopPremiumFrequencyType",
        #  "primaryInsuredMemberIdentifier",
        #  "employeeWillDropCoverageDate",
        #  "employeeWillDropCoverageIndicator",
        #  "planToEnrollEscDate",
        #  "employeeStatus",
        #  "waitingPeriodIndicator",
        #  "insurancePlanName",
        #  "insurancePolicyMemberId",
        #  "insurancePolicyNumber",
        #  "employeeCouldStartCoverageDate",
        #  "retireePlanCoverageIndicator",
        #  "employerWillStopProvidingCoverageDate"]
      # employer
        # ["name", "streetName1", "cityName", "stateCode",
        #  "zipCode", "employerPhoneNumber", "contact",
        #  "employerIdentificationNumber", "streetName2", "plus4Code"]

      # hraOffers
        # ["hraType", "startDate", "noticeDate",
        #  "enrolledInOfferFromSameEmployerIndicator",
        #  "enrolledInOfferFromSameEmployerUntilStartDateIndicator", "endDate",
        #  "primaryInsuredMemberIdentifier", "primaryInsuredMemberNotInTaxHhIndicator",
        #  "employeeSelfOnlyOfferAmount", "employeeSelfOnlyOfferFrequencyType", "employer"]

      #Mediaid
        # ["medicaidDeniedDate", "medicaidDeniedIndicator", "enrolledInHealthCoverageIndicator",
        #  "insuranceCoverage", "informationChangeSinceMedicaidEndedIndicator", "medicaidEndIndicator",
        #  "coveredDependentChildIndicator", "medicaidDeniedDueToImmigrationIndicator",
        #  "unpaidBillIndicator", "medicaidEndDate", "immigrationStatusFiveYearIndicator",
        #  "immigrationStatusChangeSinceDeniedIndicator"]

        # insuranceCoverage
        # ["insuranceMarketType", "insurancePlanName", "insurancePolicyNumber", "insurancePolicyMemberId"]
        # insuranceMarketType
          # ["MARKETPLACE_COVERAGE", "OTHER_LIMITED_BENEFIT_COVERAGE", "CHIP", "OTHER_FULL_BENEFIT_COVERAGE",
          #  "MEDICAID", "EMPLOYER_SPONSORED", "MEDICARE", "NONE", "PEACE_CORPS", "VETERAN_HEALTH_PROGRAM"]

      # Chip
      # ["coverageEndedIndicator", "stateHealthBenefitIndicator"]

      # nonMagi
      # ["blindOrDisabledIndicator", "longTermCareIndicator"]

      # other
      # ["incarcerationType", "reconcilePtcIndicatorType", "appliedDuringOeOrLifeChangeIndicator",
      #  "changeInCircumstance", "supportingPhysicalDocument", "veteranIndicator",
      #  "veteranSelfIndicator", "americanIndianAlaskanNative"]

      def call(cache, m_identifier = nil)
        @insurance_coverage_hash = cache.find(Regexp.new("attestations.members.#{m_identifier}.insuranceCoverage"))&.first&.item
        @medicaid_hash = cache.find(Regexp.new("attestations.members.#{m_identifier}.medicaid"))&.first&.item
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

        @insurance_coverage_hash[:employerSponsoredCoverageOffers].collect do |_k, esc|
          # if offeredEmployeeCoverage & employerOffersMinValuePlan is 'YES' then proceed to next step
          next unless @insurance_coverage_hash[:offeredEmployeeCoverage] == "YES" && esc[:employerOffersMinValuePlan] == "YES"
          esc_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_eligible",
                                                                                 phone: emp_phone(esc)))
          esc_hash[:employer].delete(:employer_phone) if esc_hash[:employer] && emp_phone(esc).blank?
          esc_hash
        end
      end

      def offered_hra_hash
        return [] if !@insurance_coverage_hash[:offeredIchraIndicator] && @insurance_coverage_hash[:enrolledInIchraIndicator]
        return [] unless @insurance_coverage_hash[:hraOffers]

        @insurance_coverage_hash[:hraOffers].collect do |hra|
          next unless hra[:employer]
          hra_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(hra.merge(kind: 'health_reimbursement_arrangement', :status => "is_eligible",
                                                                                 phone: emp_phone(hra)))
          hra_hash[:employer].delete(:employer_phone) if hra_hash[:employer] && emp_phone(hra).blank?
          hra_hash
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_hash
        result = []
        @insurance_coverage_hash[:enrolledCoverages].each do |enrolled_coverage|
          next if ['NONE', 'EMPLOYER_SPONSORED'].include?(enrolled_coverage[:insuranceMarketType])
          if enrolled_coverage[:insuranceMarketType] == "INDIVIDUAL_INSURANCE" && @medicaid_hash[:insuranceCoverage]
            # TODO what need to be done for EMPLOYER_SPONSORED for medicaid when "INDIVIDUAL_INSURANCE"
            @medicaid_hash[:insuranceCoverage].each do |medicaid_coverage|
              next if ['NONE', 'EMPLOYER_SPONSORED'].include?(medicaid_coverage[:insuranceMarketType])
              next unless @medicaid_hash[:enrolledInHealthCoverageIndicator]
              result << {
                  kind: Ffe::Types::BenefitsKindMapping[medicaid_coverage[:insuranceMarketType].to_sym],
                  status: 'is_enrolled',
                  start_on: Date.parse('2021-01-01'), # default value
                  end_on: medicaid_coverage[:medicaidEndIndicator] ? medicaid_coverage[:medicaidEndDate] : nil
              }
            end
          else
            next unless Ffe::Types::BenefitsKindMapping[enrolled_coverage[:insuranceMarketType].to_sym]
            result << {
                kind: Ffe::Types::BenefitsKindMapping[enrolled_coverage[:insuranceMarketType].to_sym],
                status: 'is_enrolled',
                start_on: Date.parse('2021-01-01'), # default value
                end_on: nil
            }
          end
        end
        result
      end

      def enrolled_hra_hash
        return [] if !@insurance_coverage_hash[:enrolledInIchraIndicator] && @insurance_coverage_hash[:offeredIchraIndicator]
        return [] unless @insurance_coverage_hash[:hraOffers]

        @insurance_coverage_hash[:hraOffers].collect do |hra, _k|
          employer = if @insurance_coverage_hash[:employerSponsoredCoverageOffers]
                       hra.merge!(@insurance_coverage_hash[:employerSponsoredCoverageOffers].first[1])
                     else
                       hra[:employer]
                     end
          next unless employer
          hra_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(hra.merge(kind: 'health_reimbursement_arrangement', :status => "is_enrolled",
                                                                                 phone: emp_phone(hra)))
          hra_hash[:employer].delete(:employer_phone) if hra_hash[:employer] && emp_phone(hra).blank?
          hra_hash
        end
      end

      # Is this person currently enrolled in health coverage or getting help paying for health coverage through a Health Reimbursement Arrangement? *
      def enrolled_esc_hash
        return [] unless @insurance_coverage_hash[:employerSponsoredCoverageOffers]

        # if insuranceMarketType is 'EMPLOYER_SPONSORED' then proceed to next step
        enrolled_coverages = @insurance_coverage_hash[:enrolledCoverages].select {|ec| ec[:insuranceMarketType] == 'EMPLOYER_SPONSORED'}
        return [] if enrolled_coverages.empty?

        @insurance_coverage_hash[:employerSponsoredCoverageOffers].collect do |_k, esc|
          next unless esc[:escEnrolledIndicator]
          esc_hash = AcaEntities::Ffe::Transformers::Cv::Esc.transform(esc.merge(kind: 'employer_sponsored_insurance', :status => "is_enrolled",
                                                                                 phone: emp_phone(esc)))
          esc_hash[:employer].delete(:employer_phone) if esc_hash[:employer] && emp_phone(esc).blank?
          esc_hash
        end
      end

      def emp_phone(esc)
        return '' if esc[:employer].nil?

        if !esc[:employer][:employerPhoneNumber].nil?
          esc[:employer][:employerPhoneNumber]
        elsif !esc[:employer][:contact].nil?
          esc[:employer][:contact][:phoneNumber]
        else
          ''
        end
      end
    end
  end
end
# rubocop:enable  Lint/UnreachableCode
