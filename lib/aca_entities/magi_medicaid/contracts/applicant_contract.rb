# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Applicant}
      # rubocop:disable Metrics/ClassLength
      class ApplicantContract < Dry::Validation::Contract
        include AcaEntities::AppHelper
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
        # @option opts [Array] :addresses optional
        # @option opts [Array] :emails optional
        # @option opts [Array] :phones optional
        # @option opts [Array] :incomes optional
        # @option opts [Array] :benefits optional
        # @option opts [Array] :deductions optional
        # @return [Dry::Monads::Result]
        params do
          required(:name).filled(AcaEntities::Contracts::PersonNameContract.params)
          required(:identifying_information).filled(IdentifyingInformationContract.params)
          required(:demographic).filled(DemographicContract.params)
          required(:attestation).filled(AttestationContract.params)
          required(:is_primary_applicant).filled(:bool)
          optional(:native_american_information).maybe(NativeAmericanInformationContract.params)
          optional(:citizenship_immigration_status_information).maybe(CitizenshipImmigrationStatusInformationContract.params)
          optional(:is_consumer_role).maybe(:bool)
          optional(:is_resident_role).maybe(:bool)
          required(:is_applying_coverage).filled(:bool)
          optional(:is_consent_applicant).maybe(:bool)
          optional(:vlp_document).maybe(AcaEntities::Contracts::VlpDocumentContract.params)
          required(:family_member_reference).filled(:hash) # AcaEntities::Contracts::References::FamilyMemberContract.params
          required(:person_hbx_id).filled(:string)
          required(:is_required_to_file_taxes).filled(:bool)
          optional(:is_joint_tax_filing).maybe(:bool)
          optional(:is_claimed_as_tax_dependent).maybe(:bool)
          optional(:claimed_as_tax_dependent_by).maybe(ApplicantReferenceContract.params)
          optional(:tax_filer_kind).maybe(Types::TaxFilerKind)
          optional(:student).maybe(StudentContract.params)
          optional(:is_refugee).maybe(:bool)
          optional(:is_trafficking_victim).maybe(:bool)
          optional(:foster_care).maybe(FosterCareContract.params)
          required(:pregnancy_information).filled(PregnancyInformationContract.params)
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

          optional(:addresses).array(AcaEntities::Contracts::AddressContract.params)
          optional(:emails).array(AcaEntities::Contracts::EmailContract.params)
          optional(:phones).array(AcaEntities::Contracts::PhoneContract.params)
          optional(:incomes).array(IncomeContract.params)
          optional(:benefits).array(BenefitContract.params)
          optional(:deductions).array(DeductionContract.params)
        end

        rule(:demographic) do
          if value.is_a?(Hash)
            result = DemographicContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid demographic', error: result.errors.to_h)
            else
              values.merge!(demographic: result.to_h)
            end
          else
            key.failure(text: 'invalid demographic. Expected a hash.')
          end
        end

        rule(:attestation) do
          if value.is_a?(Hash)
            result = AttestationContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid attestation', error: result.errors.to_h)
            else
              values.merge!(attestation: result.to_h)
            end
          else
            key.failure(text: 'invalid attestation. Expected a hash.')
          end
        end

        rule(:native_american_information) do
          if key? && value
            if value.is_a?(Hash)
              result = NativeAmericanInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid native_american_information', error: result.errors.to_h)
              else
                values.merge!(native_american_information: result.to_h)
              end
            else
              key.failure(text: 'invalid native_american_information. Expected a hash.')
            end
          end
        end

        rule(:is_claimed_as_tax_dependent) do
          key.failure(text: 'cannot be blank') if key? && values[:is_required_to_file_taxes] && check_if_blank?(value)
        end

        rule(:student) do
          if key? && values[:is_applying_coverage]
            if value.is_a?(Hash)
              result = StudentContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid student', error: result.errors.to_h)
              else
                values.merge!(student: result.to_h)
              end
            else
              key.failure(text: 'invalid student. Expected a hash.')
            end
          end
        end

        rule(:foster_care) do
          if key? && values[:is_applying_coverage]
            if value.is_a?(Hash)
              result = FosterCareContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid foster_care', error: result.errors.to_h)
              else
                values.merge!(foster_care: result.to_h)
              end
            else
              key.failure(text: 'invalid foster_care. Expected a hash.')
            end
          end
        end

        rule(:pregnancy_information) do
          if key? && value
            if value.is_a?(Hash)
              result = PregnancyInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid pregnancy_information', error: result.errors.to_h)
              else
                values.merge!(pregnancy_information: result.to_h)
              end
            else
              key.failure(text: 'invalid pregnancy_information. Expected a hash.')
            end
          end
        end

        def any_income?(values)
          values[:has_job_income] || values[:has_self_employment_income] || values[:has_unemployment_income] || values[:has_other_income]
        end

        rule(:incomes) do
          if any_income?(values)
            key.failure(text: 'invalid input data for incomes.') if check_if_blank?(value)
            incomes_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = IncomeContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid income', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid income. Expected a hash.')
              end
              hash_array
            end
            values.merge!(incomes: incomes_array)
          end
        end

        rule(:deductions) do
          if values[:has_deductions]
            key.failure(text: 'invalid input data for deductions.') if check_if_blank?(value)
            deductions_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = DeductionContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid deduction', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid deduction. Expected a hash.')
              end
              hash_array
            end
            values.merge!(deductions: deductions_array)
          end
        end

        def any_benefit?(values)
          values[:has_enrolled_health_coverage] || values[:has_eligible_health_coverage]
        end

        rule(:benefits) do
          if any_benefit?(values)
            key.failure(text: 'invalid input data for benefits.') if check_if_blank?(value)
            benefits_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = BenefitContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid benefit', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid benefit. Expected a hash.')
              end
              hash_array
            end
            values.merge!(benefits: benefits_array)
          end
        end

        rule(:addresses) do
          if key? && value
            addresses_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = AcaEntities::Contracts::AddressContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid address', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid address. Expected a hash.')
              end
              hash_array
            end
            values.merge!(addresses: addresses_array)
          end
        end

        rule(:phones) do
          if key? && value
            phones_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = AcaEntities::Contracts::PhoneContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid phone', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid phone. Expected a hash.')
              end
              hash_array
            end
            values.merge!(phones: phones_array)
          end
        end

        rule(:emails) do
          if key? && value
            emails_array = value.inject([]) do |hash_array, id_hash|
              if id_hash.is_a?(Hash)
                result = AcaEntities::Contracts::EmailContract.new.call(id_hash)
                if result&.failure?
                  key.failure(text: 'invalid email', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid email. Expected a hash.')
              end
              hash_array
            end
            values.merge!(emails: emails_array)
          end
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
