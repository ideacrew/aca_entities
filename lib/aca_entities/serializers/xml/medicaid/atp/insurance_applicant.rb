# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A person requesting insurance coverage (either to obtain a new policy or to maintain enrollment in an existing policy).
          class InsuranceApplicant
            include HappyMapper

            tag 'InsuranceApplicant'
            namespace 'hix-ee'

            has_one :role_reference, RoleOfPersonReference

            # True if the applicant is blind or disabled; false otherwise
            element :blindness_or_disability_indicator, Boolean, tag: 'InsuranceApplicantBlindnessOrDisabilityIndicator'

            # True if an applicant has been enrolled in health insurance during the previous six months; false otherwise.
            element :coverage_during_previous_six_months_indicator, Boolean, tag: 'InsuranceApplicantCoverageDuringPreviousSixMonthsIndicator'

            # True if the applicant is eligible for Indian Health Service/Tribal/Urban Indian Health (I/T/U) services; false otherwise
            element :eligible_itu_services_indicator, Boolean, tag: 'InsuranceApplicantEligibleITUServicesIndicator'

            # True if the applicant has a fixed address; false otherwise.
            element :fixed_address_indicator, Boolean, tag: 'InsuranceApplicantFixedAddressIndicator'

            # A description of the applicant's incarceration history.
            has_many :incarcerations, Incarceration

            # A status of the applicant's lawful presence in the United States
            has_one :lawful_presence_status, InsuranceApplicantLawfulPresenceStatus

            # An indication of whether or not the applicant has an absent parent or spouse.
            element :absent_parent_or_spouse_code, String, tag: 'InsuranceApplicantAbsentParentOrSpouseCode'

            # True if an applicant requires long term care; false otherwise.
            element :long_term_care_indicator, Boolean, tag: 'InsuranceApplicantLongTermCareIndicator'

            # True if an applicant is enrolled in a non-employer sponsored insurance (ESI) plan; false otherwise.
            has_many :non_esi_coverage_indicators, Boolean, tag: 'InsuranceApplicantNonESICoverageIndicator'

            # True if an applicant is a parent or caretaker of a child on the application; false otherwise.
            element :parent_caretaker_indicator, Boolean, tag: 'InsuranceApplicantParentCaretakerIndicator'

            # True if an applicant has ever received Indian Health Service/Tribal/Urban Indian Health (I/T/U) services; false otherwise.
            element :received_itu_services_indicator, Boolean, tag: 'InsuranceApplicantReceivedITUServicesIndicator'

            # True if an applicant has medical bills within the last ninety days; false otherwise.
            element :recent_medical_bills_indicator, Boolean, tag: 'InsuranceApplicantRecentMedicalBillsIndicator'

            # True if an applicant has access to state benefits through a relationship to a public employee; false otherwise.
            element :state_benefits_through_public_employee_indicator, Boolean, tag: 'InsuranceApplicantStateBenefitsThroughPublicEmployeeIndicator'

            # True if an adult applicant older than 19 and less than 21 years old is a full-time student; false otherwise.
            element :student_indicator, Boolean, tag: 'InsuranceApplicantStudentIndicator'

            # Relationships between an applicant and an employer sponsored insurance arrangement.
            has_many :esi_associations, EsiAssociation

            # An insurance policy associated with an applicant that is not an employer sponsored insurance (ESI) arrangement.
            has_many :non_esi_policies, InsuranceApplicantNonEsiPolicy

            # the various eligibilities are a choice, you can have only on them
            has_many :emergency_medicaid_eligibilities, EmergencyMedicaidEligibility
            has_many :medicaid_magi_eligibilities, MedicaidMagiEligibility
            has_many :medicaid_non_magi_eligibilities, MedicaidNonMagiEligibility
            has_many :aptc_eligibilities, AptcEligibility
            has_many :exchange_eligibilities, ExchangeEligibility
            has_many :csr_eligibilities, CsrEligibility
            has_many :chip_eligibilities, ChipEligibility
            # RefugeeMedicalAssistanceEligibility TBD

            # True if an applicant temporarily lives outside the state under which an application is made; false otherwise.
            element :temporarily_lives_outside_application_state_indicator, Boolean,
                    tag: 'InsuranceApplicantTemporarilyLivesOutsideApplicationStateIndicator'

            # An age when an applicant left foster care.
            element :age_left_foster_care, Integer, tag: 'InsuranceApplicantAgeLeftFosterCare'

            # A state in which an applicant was provided foster care.
            element :foster_care_state, String, tag: 'InsuranceApplicantFosterCareState'

            # True if the applicant received Medicaid benefits while in foster care; false otherwise.
            element :had_medicaid_during_foster_care_indicator, Boolean, tag: 'InsuranceApplicantHadMedicaidDuringFosterCareIndicator'

            # True if claiming tax filer is a non-custodial parent and if the claiming tax filer can be considered a caretaker relative; else false.
            element :lives_with_minor_age_dependent_indicator, Boolean, tag: 'InsuranceApplicantLivesWithMinorAgeDependentIndicator'

            # True if an applicant's Medicaid household differs from her/his tax household based on Medicaid MAGI eligibility rules; false otherwise.
            element :household_exception_indicator, Boolean, tag: 'InsuranceApplicantHouseholdExceptionIndicator'

            # A referral of an insurance applicant from one information exchange system to another.
            has_one :referral_activity, ReferralActivity

            # True if the applicant has ever been in foster care; false otherwise.
            element :foster_care_indicator, Boolean, tag: 'InsuranceApplicantFosterCareIndicator'

            # An average number of hours worked (in total) by a parent of an applicant. Max of two values.
            element :parent_average_hours_worked_per_week_values, Float, tag: 'InsuranceApplicantParentAverageHoursWorkedPerWeekValue'

            def self.domain_to_mapper(insurance_applicant)
              mapper = self.new
              mapper.fixed_address_indicator = insurance_applicant.fixed_address_indicator
              mapper.blindness_or_disability_indicator = insurance_applicant.blindness_or_disability_indicator
              mapper.coverage_during_previous_six_months_indicator = insurance_applicant.coverage_during_previous_six_months_indicator
              mapper.role_reference = RoleOfPersonReference.domain_to_mapper(insurance_applicant.role_reference)
              if insurance_applicant.incarcerations
                mapper.incarcerations = insurance_applicant.incarcerations.map { |inc| Incarceration.domain_to_mapper(inc) }
              end
              mapper.lawful_presence_status = InsuranceApplicantLawfulPresenceStatus.domain_to_mapper(insurance_applicant.lawful_presence_status)
              mapper.chip_eligibilities = insurance_applicant.chip_eligibilities&.map do |chip_eligibility|
                ChipEligibility.domain_to_mapper(chip_eligibility)
              end
              mapper.medicaid_magi_eligibilities = insurance_applicant.medicaid_magi_eligibilities&.map do |medicaid_magi_eligibility|
                MedicaidMagiEligibility.domain_to_mapper(medicaid_magi_eligibility)
              end
              if insurance_applicant&.referral_activity
                mapper.referral_activity = ReferralActivity.domain_to_mapper(insurance_applicant&.referral_activity)
              end
              mapper
            end

            def to_hash # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
              {
                id: role_reference ? role_reference.to_hash[:ref] : nil,
                role_reference: role_reference&.to_hash,
                fixed_address_indicator: fixed_address_indicator,
                incarcerations: incarcerations.map(&:to_hash),
                absent_parent_or_spouse_code: absent_parent_or_spouse_code,
                blindness_or_disability_indicator: blindness_or_disability_indicator,
                coverage_during_previous_six_months_indicator: coverage_during_previous_six_months_indicator,
                eligible_itu_services_indicator: eligible_itu_services_indicator,
                lawful_presence_status: lawful_presence_status&.to_hash,
                long_term_care_indicator: long_term_care_indicator,
                non_esi_coverage_indicators: non_esi_coverage_indicators,
                parent_caretaker_indicator: parent_caretaker_indicator,
                received_itu_services_indicator: received_itu_services_indicator,
                recent_medical_bills_indicator: recent_medical_bills_indicator,
                state_benefits_through_public_employee_indicator: state_benefits_through_public_employee_indicator,
                student_indicator: student_indicator,
                esi_associations: esi_associations.map(&:to_hash),
                non_esi_policies: non_esi_policies.map(&:to_hash),
                emergency_medicaid_eligibilities: emergency_medicaid_eligibilities.map(&:to_hash),
                medicaid_magi_eligibilities: medicaid_magi_eligibilities.map(&:to_hash),
                medicaid_non_magi_eligibilities: medicaid_non_magi_eligibilities.map(&:to_hash),
                aptc_eligibilities: aptc_eligibilities.map(&:to_hash),
                exchange_eligibilities: exchange_eligibilities.map(&:to_hash),
                csr_eligibilities: csr_eligibilities.map(&:to_hash),
                chip_eligibilities: chip_eligibilities.map(&:to_hash),
                temporarily_lives_outside_application_state_indicator: temporarily_lives_outside_application_state_indicator,
                age_left_foster_care: age_left_foster_care,
                foster_care_state: foster_care_state,
                had_medicaid_during_foster_care_indicator: had_medicaid_during_foster_care_indicator,
                lives_with_minor_age_dependent_indicator: lives_with_minor_age_dependent_indicator,
                household_exception_indicator: household_exception_indicator,
                # referral_activity: referral_activity&.to_hash, # revisit this element
                foster_care_indicator: foster_care_indicator,
                parent_average_hours_worked_per_week_values: parent_average_hours_worked_per_week_values
              }
            end
          end
        end
      end
    end
  end
end