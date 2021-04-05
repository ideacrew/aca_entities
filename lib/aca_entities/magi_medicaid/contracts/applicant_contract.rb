# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Applicant
      # rubocop:disable Metrics/ClassLength
      class ApplicantContract < Dry::Validation::Contract
        params do
          required(:name).filled(:hash)
          required(:identifying_information).filled(:hash)
          required(:demographic).filled(:hash)
          required(:attestation).filled(:hash)
          required(:is_primary_applicant).filled(:bool)
          optional(:native_american_information).maybe(:hash)
          optional(:citizenship_immigration_status_information).maybe(:hash)
          optional(:is_consumer_role).maybe(:bool)
          optional(:is_resident_role).maybe(:bool)
          required(:is_applying_coverage).filled(:bool)
          optional(:is_consent_applicant).maybe(:bool)
          optional(:vlp_document).maybe(:hash)
          required(:family_member_reference).filled(:hash)
          required(:person_hbx_id).filled(:string)
          required(:is_required_to_file_taxes).filled(:bool)
          optional(:is_joint_tax_filing).maybe(:bool)
          optional(:is_claimed_as_tax_dependent).maybe(:bool)
          optional(:claimed_as_tax_dependent_by).maybe(:hash)
          optional(:tax_filer_kind).maybe(Types::TaxFilerKind)
          optional(:student).maybe(:hash)
          optional(:is_refugee).maybe(:bool)
          optional(:is_trafficking_victim).maybe(:bool)
          optional(:foster_care).maybe(:hash)
          required(:pregnancy_information).filled(:hash)
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

          optional(:addresses).array(:hash)
          optional(:emails).array(:hash)
          optional(:phones).array(:hash)
          optional(:incomes).array(:hash)
          optional(:benefits).array(:hash)
          optional(:deductions).array(:hash)
        end

        rule(:name) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::PersonNameContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid name', error: result.errors.to_h)
              else
                values.merge!(name: result.to_h)
              end
            else
              key.failure(text: 'invalid name. Expected a hash.')
            end
          end
        end

        rule(:identifying_information) do
          if key? && value
            if value.is_a?(Hash)
              result = IdentifyingInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid identifying_information', error: result.errors.to_h)
              else
                values.merge!(identifying_information: result.to_h)
              end
            else
              key.failure(text: 'invalid identifying_information. Expected a hash.')
            end
          end
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

        rule(:citizenship_immigration_status_information) do
          if key? && value
            if value.is_a?(Hash)
              result = CitizenshipImmigrationStatusInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid citizenship_immigration_status_information', error: result.errors.to_h)
              else
                values.merge!(citizenship_immigration_status_information: result.to_h)
              end
            else
              key.failure(text: 'invalid citizenship_immigration_status_information. Expected a hash.')
            end
          end
        end

        # rule(:family_member_reference) do
        #   if key? && value
        #     if value.is_a?(Hash)
        #       result = AcaEntities::Contracts::References::FamilyMemberContract.new.call(value)
        #       if result&.failure?
        #         key.failure(text: 'invalid family_member_reference', error: result.errors.to_h)
        #       else
        #         values.merge!(family_member_reference: result.to_h)
        #       end
        #     else
        #       key.failure(text: 'invalid family_member_reference. Expected a hash.')
        #     end
        #   end
        # end

        rule(:vlp_document) do
          if key? && value
            if value.is_a?(Hash)
              result = VlpDocumentContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid vlp_document', error: result.errors.to_h)
              else
                values.merge!(vlp_document: result.to_h)
              end
            else
              key.failure(text: 'invalid vlp_document. Expected a hash.')
            end
          end
        end

        rule(:is_claimed_as_tax_dependent) do
          key.failure(text: 'cannot be blank') if key? && values[:is_required_to_file_taxes] && check_if_blank?(value)
        end

        rule(:claimed_as_tax_dependent_by) do
          if values[:is_required_to_file_taxes] && values[:is_claimed_as_tax_dependent]
            if check_if_blank?(value)
              key.failure(text: 'cannot be blank')
            elsif value.is_a?(Hash)
              result = ApplicantReferenceContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid claimed_as_tax_dependent_by.', error: result.errors.to_h)
              else
                values.merge!(claimed_as_tax_dependent_by: result.to_h)
              end
            end
          end
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

        rule(:incomes).each do
          if key? && value && any_income?(values)
            if value.is_a?(Hash)
              result = IncomeContract.new.call(value)
              key.failure(text: "invalid income", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid incomes. Expected a hash.")
            end
          end
        end

        rule(:deductions).each do
          if key? && value && values[:has_deductions]
            if value.is_a?(Hash)
              result = DeductionContract.new.call(value)
              key.failure(text: "invalid deduction", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid deductions. Expected a hash.")
            end
          end
        end

        def any_benefit?(values)
          values[:has_enrolled_health_coverage] || values[:has_eligible_health_coverage]
        end

        rule(:benefits).each do
          if key? && value && any_benefit?(values)
            if value.is_a?(Hash)
              result = BenefitContract.new.call(value)
              key.failure(text: "invalid benefit", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid benefits. Expected a hash.")
            end
          end
        end

        rule(:addresses).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::AddressContract.new.call(value)
              key.failure(text: "invalid address", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid addresses. Expected a hash.")
            end
          end
        end

        rule(:phones).each do
          if key? && value
            if value.is_a?(Hash)
              result = PhoneContract.new.call(value)
              key.failure(text: "invalid phone", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid phones. Expected a hash.")
            end
          end
        end

        rule(:emails).each do
          if key? && value
            if value.is_a?(Hash)
              result = EmailContract.new.call(value)
              key.failure(text: "invalid email", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid emails. Expected a hash.")
            end
          end
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
