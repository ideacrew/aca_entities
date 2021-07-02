# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for Applicant.
    class Applicant < Dry::Struct
      # All common entities across all the subs lives at aca_entities level just like address.
      attribute :name, AcaEntities::People::PersonName.meta(omittable: false)
      attribute :identifying_information, IdentifyingInformation.meta(omittable: false)
      attribute :demographic, Demographic.meta(omittable: false)
      attribute :attestation, Attestation.optional.meta(omittable: true)
      attribute :is_primary_applicant, Types::Bool.meta(omittable: false)
      attribute :native_american_information, NativeAmericanInformation.optional.meta(omittable: true)
      attribute :citizenship_immigration_status_information, CitizenshipImmigrationStatusInformation.meta(omittable: false)

      attribute :is_consumer_role, Types::Bool.optional.meta(omittable: true)
      attribute :is_resident_role, Types::Bool.optional.meta(omittable: true)
      attribute :is_applying_coverage, Types::Bool.optional.meta(omittable: true)
      attribute :is_consent_applicant, Types::Bool.optional.meta(omittable: true)
      attribute :vlp_document, AcaEntities::Documents::VlpDocument.optional.meta(omittable: true)
      attribute :family_member_reference, AcaEntities::Families::FamilyMemberReference.meta(omittable: false)

      attribute :person_hbx_id, Types::String.meta(omittable: false)

      attribute :is_required_to_file_taxes, Types::Bool.optional.meta(omittable: true)
      attribute :tax_filer_kind, Types::TaxFilerKind.optional.meta(omittable: true)
      attribute :is_joint_tax_filing, Types::Bool.optional.meta(omittable: true)
      attribute :is_claimed_as_tax_dependent, Types::Bool.optional.meta(omittable: true)
      attribute :claimed_as_tax_dependent_by, ApplicantReference.optional.meta(omittable: true)

      attribute :student, Student.optional.meta(omittable: true)
      attribute :is_refugee, Types::Bool.optional.meta(omittable: true)
      attribute :is_trafficking_victim, Types::Bool.optional.meta(omittable: true)
      attribute :foster_care, FosterCare.optional.meta(omittable: true)
      attribute :pregnancy_information, PregnancyInformation.optional.meta(omittable: true)

      # TODO: do we want to move these anywhere?
      attribute :is_subject_to_five_year_bar, Types::Bool.optional.meta(omittable: true)
      attribute :is_five_year_bar_met, Types::Bool.optional.meta(omittable: true)
      attribute :is_forty_quarters, Types::Bool.optional.meta(omittable: true)
      attribute :is_ssn_applied, Types::Bool.optional.meta(omittable: true)
      attribute :non_ssn_apply_reason, Types::String.optional.meta(omittable: true)
      # 5 Yr. Bar QNs.
      attribute :moved_on_or_after_welfare_reformed_law, Types::Bool.optional.meta(omittable: true)
      attribute :is_currently_enrolled_in_health_plan, Types::Bool.optional.meta(omittable: true)

      # Other QNs.
      attribute :has_daily_living_help, Types::Bool.optional.meta(omittable: true)
      attribute :need_help_paying_bills, Types::Bool.optional.meta(omittable: true)

      # Driver QNs.
      attribute :has_job_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_self_employment_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_unemployment_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_other_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_deductions, Types::Bool.optional.meta(omittable: true)
      attribute :has_enrolled_health_coverage, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] has_eligible_health_coverage
      # Does this person currently have access to other health coverage that they are not enrolled in,
      # including coverage they could get through another person?
      # @return [Bool]
      attribute :has_eligible_health_coverage, Types::Bool.optional.meta(omittable: true)
      # Driver QNs.

      # @!attribute [r] job_coverage_ended_in_past_3_months
      # Did this person have coverage through a job (for example, a parent's job)
      # that ended in the last 3 months?
      # @return [Bool]
      attribute :job_coverage_ended_in_past_3_months, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] job_coverage_end_date
      # This relates to job_coverage_ended_in_past_3_months
      # What was the last day this person had coverage through the job?
      # @return [Bool]
      attribute :job_coverage_end_date, Types::Bool.optional.meta(omittable: true)

      attribute :medicaid_and_chip, MedicaidAndChip.optional.meta(omittable: true)
      attribute :other_health_service, OtherHealthService.optional.meta(omittable: true)

      attribute :addresses, Types::Array.of(AcaEntities::Locations::Address).optional.meta(omittable: true)
      attribute :emails, Types::Array.of(AcaEntities::Contacts::EmailContact).optional.meta(omittable: true)
      attribute :phones, Types::Array.of(AcaEntities::Contacts::PhoneContact).optional.meta(omittable: true)

      attribute :incomes,         Types::Array.of(Income).optional.meta(omittable: true)
      attribute :benefits,        Types::Array.of(Benefit).optional.meta(omittable: true)
      attribute :deductions,      Types::Array.of(Deduction).optional.meta(omittable: true)

      # @!attribute [r] is_medicare_eligible
      # A boolean that tells if applicant has any medicare benefits('medicare', 'medicare_advantage', or 'medicare_part_b').
      # @return [Bool]
      attribute :is_medicare_eligible, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] has_insurance
      # Applicant already has insurance coverage. Any benefits of type is_enrolled
      # @return [Bool]
      attribute :has_insurance, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] has_state_health_benefit
      # A boolean if applicant has health benefits by virtue working for a public entity or through a relative
      # Any benefits of type medicaid
      # @return [Bool]
      attribute :has_state_health_benefit, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] had_prior_insurance
      # Was the applicant receiving coverage that has expired?
      # Any benefits of type is_enrolled and end dated.
      # @return [Bool]
      attribute :had_prior_insurance, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] prior_insurance_end_date
      # The date the prior coverage ended.A date in YYYY-MM-DD format
      # @return [Bool]
      attribute :prior_insurance_end_date, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] age_of_applicant
      # The age of the applicant
      # @return [Integer]
      attribute :age_of_applicant, Types::Integer.meta(omittable: false)

      # @!attribute [r] is_self_attested_long_term_care
      # @return [Bool]
      attribute :is_self_attested_long_term_care, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] hours_worked_per_week
      # @return [Integer]
      attribute :hours_worked_per_week, Types::Integer.optional.meta(omittable: true)

      # @!attribute [r] is_temporarily_out_of_state
      # Applicant is currently living outside State of Application
      # @return [Bool]
      attribute :is_temporarily_out_of_state, Types::Bool.optional.meta(omittable: true)

      # @!attribute [r] is_claimed_as_dependent_by_non_applicant
      # Applicant is claimed as dependent by a person who is not applying for coverage(is_applying_coverage).
      # @return [Bool]
      attribute :is_claimed_as_dependent_by_non_applicant, Types::Bool.optional.meta(omittable: true)

      attribute :benchmark_premium, BenchmarkPremium.meta(omittable: false)

      # @!attribute [r] is_homeless
      # This person is a state resident who is experiencing homeless(insured.dependent_dc_homeless)
      # @return [Bool]
      attribute :is_homeless, Types::Bool

      # Set of attributes specific to MitC which helps to not have much logic in IapTo MitC Transform.
      attribute :mitc_income, AcaEntities::MagiMedicaid::Mitc::Income.optional.meta(omittable: true)
      attribute :mitc_relationships, Types::Array.of(AcaEntities::MagiMedicaid::Mitc::Relationship).optional.meta(omittable: true)
      attribute :mitc_is_required_to_file_taxes, Types::Bool.optional.meta(omittable: true)

      # mitc_is_required_to_file_taxes is special attribute that is used to bypass some of the Income rules of Mitc.

      # Mitc has some rules to Include/Exclude Income which do not match with any policy per Sarah:
      # 1. Your income is counted if you are Required to File Taxes
      # 2. Your income is NOT counted if you are in the Medicaid household of a parent/stepparent (in any household)
      # 3. Your income is NOT counted in the household of a non-parent/stepparent who claims you as a dependent
      #    (only in the household of the tax filer)

      def monthly_qsehra_amount
        BigDecimal('0')
        # qsehra_benefits = benefits.select { |benefit| benefit.kind == 'qsehra' }
        # qsehra_benefits.map(&:monthly_employee_cost)
      end

      def minimum_essential_coverages
        return [] if benefits.blank?

        benefits.select do |benefit|
          Types::MinimumEssentialCoverageBenefitKinds.include?(benefit.kind)
        end
      end

      def incarcerated?
        attestation&.is_incarcerated
      end

      # US citizen or immigrant lawfully present
      def lawfully_present_in_us?
        citizen_status = citizenship_immigration_status_information&.citizen_status
        return nil unless citizen_status
        Types::LawfulPresentCitizenKinds.include?(citizen_status)
      end

      # Not US citizen and did not attest to having an eligible immigration status.
      def non_citizen_and_no_lawful_presence_attestation
        citizen_status = citizenship_immigration_status_information&.citizen_status
        return nil unless citizen_status
        citizen_status != 'us_citizen' && !citizenship_immigration_status_information.is_lawful_presence_self_attested
      end

      def eligible_benefit_esis
        return [] unless has_eligible_health_coverage

        benefits.select do |benefit|
          benefit.status == 'is_eligible' && benefit.kind == 'employer_sponsored_insurance'
        end
      end

      def ichra_benefits
        return [] if benefits.blank?

        benefits.select do |ben|
          ben.kind == 'health_reimbursement_arrangement' && ben.hra_kind == :ichra
        end
      end

      def qsehra_benefits
        return [] if benefits.blank?

        benefits.select do |ben|
          ben.kind == 'health_reimbursement_arrangement' && ben.hra_kind == :qsehra
        end
      end

      def attested_for_aian?
        native_american_information&.indian_tribe_member
      end

      def home_address
        return if addresses.nil?

        addresses.detect do |address|
          address.kind == 'home'
        end
      end
    end
  end
end
