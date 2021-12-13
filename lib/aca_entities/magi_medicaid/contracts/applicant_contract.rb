# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Applicant}
      class ApplicantContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Hash] :name required
        # @option opts [Hash] :identifying_information required
        # @option opts [Hash] :demographic required
        # @option opts [Hash] :attestation required
        # @option opts [Boolean] :is_primary_applicant required
        # @option opts [Hash] :native_american_information optional
        # @option opts [Hash] :citizenship_immigration_status_information optional
        # @option opts [Boolean] :is_consumer_role optional
        # @option opts [Boolean] :is_resident_role optional
        # @option opts [Boolean] :is_applying_coverage required
        # @option opts [Boolean] :is_consent_applicant optional
        # @option opts [Hash] :vlp_document optional
        # @option opts [Hash] :family_member_reference required
        # @option opts [String] :person_hbx_id required
        # @option opts [Boolean] :is_required_to_file_taxes required
        # @option opts [Boolean] :is_filing_as_head_of_household optional
        # @option opts [Boolean] :is_joint_tax_filing optional
        # @option opts [Boolean] :is_claimed_as_tax_dependent optional
        # @option opts [Hash] :claimed_as_tax_dependent_by optional
        # @option opts [String] :tax_filer_kind optional
        # @option opts [Hash] :student optional
        # @option opts [Boolean] :is_refugee optional
        # @option opts [Boolean] :is_trafficking_victim optional
        # @option opts [Hash] :foster_care optional
        # @option opts [Hash] :pregnancy_information required
        # @option opts [Boolean] :is_subject_to_five_year_bar optional
        # @option opts [Boolean] :is_five_year_bar_met optional
        # @option opts [Boolean] :is_forty_quarters optional
        # @option opts [Boolean] :is_ssn_applied optional
        # @option opts [String] :non_ssn_apply_reason optional
        # @option opts [Boolean] :moved_on_or_after_welfare_reformed_law optional
        # @option opts [Boolean] :is_currently_enrolled_in_health_plan optional
        # @option opts [Boolean] :has_daily_living_help optional
        # @option opts [Boolean] :need_help_paying_bills optional
        # @option opts [Boolean] :has_job_income required
        # @option opts [Boolean] :has_self_employment_income required
        # @option opts [Boolean] :has_unemployment_income required
        # @option opts [Boolean] :has_other_income required
        # @option opts [Boolean] :has_deductions required
        # @option opts [Boolean] :has_enrolled_health_coverage required
        # @option opts [Boolean] :has_eligible_health_coverage required
        # @option opts [Boolean] :job_coverage_ended_in_past_3_months optional
        # @option opts [Date] :job_coverage_end_date optional
        # @option opts [AcaEntities::MagiMedicaid::Contracts::MedicaidAndChipContract] :medicaid_and_chip optional
        # @option opts [AcaEntities::MagiMedicaid::Contracts::OtherHealthServiceContract] :other_health_service optional
        # @option opts [Array] :addresses optional
        # @option opts [Array] :emails optional
        # @option opts [Array] :phones optional
        # @option opts [Array] :incomes optional
        # @option opts [Array] :benefits optional
        # @option opts [Array] :deductions optional
        # @option opts [Boolean] :is_medicare_eligible optional
        # @option opts [Boolean] :is_self_attested_long_term_care optional
        # @option opts [Boolean] :has_insurance optional
        # @option opts [Boolean] :has_state_health_benefit optional
        # @option opts [Boolean] :had_prior_insurance optional
        # @option opts [Date] :prior_insurance_end_date optional
        # @option opts [Integer] :age_of_applicant optional
        # @option opts [Boolean] :is_temporarily_out_of_state optional
        # @option opts [Integer] :hours_worked_per_week optional
        # @option opts [Boolean] :is_claimed_as_dependent_by_non_applicant optional
        # @option opts [hash] :mitc_income optional
        # @option opts [Array] :mitc_relationships optional
        # @option opts [Boolean] :mitc_is_required_to_file_taxes optional
        # @option opts [AcaEntities::MagiMedicaid::Contracts::BenchmarkPremiumContract] :benchmark_premium required
        # @option opts [Bool] :is_homeless required
        # @return [Dry::Monads::Result]
        params do
          required(:name).hash(AcaEntities::Contracts::People::PersonNameContract.params)
          required(:identifying_information).filled(IdentifyingInformationContract.params)
          required(:demographic).filled(DemographicContract.params)
          optional(:attestation).maybe(AttestationContract.params)
          required(:is_primary_applicant).filled(:bool)
          optional(:native_american_information).maybe(NativeAmericanInformationContract.params)
          required(:citizenship_immigration_status_information).hash(CitizenshipImmigrationStatusInformationContract.params)
          optional(:is_consumer_role).maybe(:bool)
          optional(:is_resident_role).maybe(:bool)
          required(:is_applying_coverage).filled(:bool)
          optional(:is_consent_applicant).maybe(:bool)
          optional(:vlp_document).maybe(AcaEntities::Contracts::Documents::VlpDocumentContract.params)
          required(:family_member_reference).hash(::AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          required(:person_hbx_id).filled(:string)
          required(:is_required_to_file_taxes).filled(:bool)
          optional(:is_filing_as_head_of_household).maybe(:bool)
          optional(:is_joint_tax_filing).maybe(:bool)
          optional(:is_claimed_as_tax_dependent).maybe(:bool)
          optional(:claimed_as_tax_dependent_by).maybe(ApplicantReferenceContract.params)
          optional(:tax_filer_kind).maybe(Types::TaxFilerKind)
          optional(:student).maybe(StudentContract.params)
          optional(:is_refugee).maybe(:bool)
          optional(:is_trafficking_victim).maybe(:bool)
          optional(:foster_care).maybe(FosterCareContract.params)
          required(:pregnancy_information).hash(PregnancyInformationContract.params)
          optional(:is_subject_to_five_year_bar).maybe(:bool)
          optional(:is_five_year_bar_met).maybe(:bool)
          optional(:is_forty_quarters).maybe(:bool)
          optional(:is_ssn_applied).maybe(:bool)
          optional(:non_ssn_apply_reason).maybe(:string)
          optional(:moved_on_or_after_welfare_reformed_law).maybe(:bool)
          optional(:is_currently_enrolled_in_health_plan).maybe(:bool)
          optional(:has_daily_living_help).maybe(:bool)
          optional(:need_help_paying_bills).maybe(:bool)

          # :incomes
          # Does this person have income from an employer(wages, tips, bonuses, etc.) in 2021?
          required(:has_job_income).filled(:bool)
          # Does this person expect to receive self-employment income in 2021?
          required(:has_self_employment_income).filled(:bool)
          # Did this person receive Unemployment Income at any point in 2021?
          required(:has_unemployment_income).filled(:bool)
          # Does this person expect to have income from other sources in 2021?
          required(:has_other_income).filled(:bool)

          # :deductions
          # Does this person expect to have income adjustments in 2021?
          required(:has_deductions).filled(:bool)

          # :benefits(Health Benefit Coverages)
          # Is this person currently enrolled in health coverage?
          required(:has_enrolled_health_coverage).filled(:bool)
          # Does this person currently have access to other health coverage that they are not enrolled in,
          # including coverage they could get through another person?
          required(:has_eligible_health_coverage).filled(:bool)

          # Is any of this person's income from American Indian or Alaska Native tribal sources? conditonal question
          optional(:has_american_indian_alaskan_native_income).maybe(:bool)

          # Did this person have coverage through a job (for example, a parent's job)
          # that ended in the last 3 months?
          optional(:job_coverage_ended_in_past_3_months).maybe(:bool)
          # What was the last day this person had coverage through the job?
          optional(:job_coverage_end_date).maybe(:date)

          optional(:medicaid_and_chip).maybe(MedicaidAndChipContract.params)
          optional(:other_health_service).maybe(OtherHealthServiceContract.params)

          optional(:addresses).array(AcaEntities::Contracts::Locations::AddressContract.params)
          optional(:emails).array(AcaEntities::Contracts::Contacts::EmailContactContract.params)
          optional(:phones).array(AcaEntities::Contracts::Contacts::PhoneContactContract.params)
          optional(:incomes).array(IncomeContract.params)
          optional(:benefits).array(BenefitContract.params)
          optional(:deductions).array(DeductionContract.params)

          optional(:is_medicare_eligible).filled(:bool)
          optional(:is_self_attested_long_term_care).maybe(:bool)
          optional(:has_insurance).filled(:bool)
          optional(:has_state_health_benefit).filled(:bool)
          optional(:had_prior_insurance).filled(:bool)
          optional(:prior_insurance_end_date).maybe(:date)
          required(:age_of_applicant).filled(:integer)

          optional(:hours_worked_per_week).filled(:integer)
          optional(:is_temporarily_out_of_state).filled(:bool)
          optional(:is_claimed_as_dependent_by_non_applicant).filled(:bool)
          required(:benchmark_premium).hash(BenchmarkPremiumContract.params)

          required(:is_homeless).filled(:bool)

          # Set of attributes specific to MitC which helps to not have much logic in IapTo MitC Transform.
          optional(:mitc_income).hash(AcaEntities::MagiMedicaid::Mitc::Contracts::IncomeContract.params)
          optional(:mitc_relationships).array(AcaEntities::MagiMedicaid::Mitc::Contracts::RelationshipContract.params)
          optional(:mitc_is_required_to_file_taxes).maybe(:bool)

          # fdsh evidences
          optional(:income_evidence).maybe(AcaEntities::Eligibilities::Contracts::EvidenceContract.params)
          optional(:esi_evidence).maybe(AcaEntities::Eligibilities::Contracts::EvidenceContract.params)
          optional(:non_esi_evidence).maybe(AcaEntities::Eligibilities::Contracts::EvidenceContract.params)
          optional(:aces_mec_evidence).maybe(AcaEntities::Eligibilities::Contracts::EvidenceContract.params)

          # fdsh esi response
          optional(:esi_eligibility_indicator).maybe(:bool)
          optional(:esi_insured_indicator).maybe(:bool)
          optional(:esi_inconsistency_indicator).maybe(:bool)

        end
      end
    end
  end
end
