# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for Applicant.
    class Applicant < Dry::Struct
      # All common entities across all the subs lives at aca_entities level just like address.
      attribute :name, AcaEntities::PersonName.meta(omittable: false)
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
      attribute :vlp_document, VlpDocument.optional.meta(omittable: true)
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
      attribute :has_other_income, Types::Bool.optional.meta(omittable: true)
      attribute :has_deductions, Types::Bool.optional.meta(omittable: true)
      attribute :has_enrolled_health_coverage, Types::Bool.optional.meta(omittable: true)
      attribute :has_eligible_health_coverage, Types::Bool.optional.meta(omittable: true)

      attribute :addresses, Types::Array.of(AcaEntities::Address).optional.meta(omittable: true)
      attribute :emails, Types::Array.of(AcaEntities::Email).optional.meta(omittable: true)
      attribute :phones, Types::Array.of(AcaEntities::Phone).optional.meta(omittable: true)

      attribute :incomes,         Types::Array.of(Income).optional.meta(omittable: true)
      attribute :benefits,        Types::Array.of(Benefit).optional.meta(omittable: true)
      attribute :deductions,      Types::Array.of(Deduction).optional.meta(omittable: true)
    end
  end
end
