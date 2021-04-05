# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Applicant.
      # rubocop:disable Metrics/ClassLength
      class ApplicantContract < Dry::Validation::Contract
        params do
          required(:person_name).filled(:hash)
          optional(:addresses).maybe(:array)
          required(:demographic).filled(:hash)
          optional(:identifying_information).maybe(:hash)
          optional(:identifying_numbers_from_documents).maybe(:array)
          required(:citizenship_immigration_status_information).filled(:hash)
          optional(:immigration_document).maybe(:hash)
          required(:native_american_information).filled(:hash)
          optional(:employer_sponsored_insurance_information).maybe(:hash)
          optional(:lowest_cost_plan).maybe(:hash)
          optional(:current_income).maybe(:hash)
          optional(:ssa_income_information).maybe(:hash)
          optional(:ssa_information).maybe(:hash)
          optional(:ssa_work_quarters).maybe(:array)
          optional(:medicaid_specific_information).maybe(:hash)
          optional(:other_insurance_coverage_information).maybe(:hash)
          optional(:other_insurance_details).maybe(:array)
          optional(:person_description_identifiers).maybe(:array)
          optional(:attestation).maybe(:hash)
          optional(:dhs_save).maybe(:hash)
          optional(:coverage_specific_information).maybe(:hash)
          optional(:coverage_period).maybe(:hash)
          optional(:relationships).maybe(:array)
          optional(:foster_care).maybe(:hash)
          optional(:basis_for_outcome).maybe(:hash)
        end

        rule(:person_name) do
          if key? && value
            if value.is_a?(Hash)
              result = PersonNameContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid person name', error: result.errors.to_h)
              else
                values.merge!(person_name: result.to_h)
              end
            else
              key.failure(text: 'invalid person name. Expected a hash.')
            end
          end
        end

        rule(:addresses) do
          if key? && value
            key.failure(text: 'Home address is required.') if required_home_address?(value)
            addresses_array = value.inject([]) do |hash_array, address_hash|
              if address_hash.is_a?(Hash)
                result = AddressContract.new.call(address_hash)
                if result&.failure?
                  key.failure(text: 'invalid address.', error: result.errors.to_h)
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

        def required_home_address?(address_hashes)
          return false unless any_fixed_address?(address_hashes)
          address_hashes.none? { |address_hash| address_hash[:kind].downcase == 'home' }
        end

        def any_fixed_address?(address_hashes)
          address_hashes.any? { |address_hash| address_hash[:has_fixed_address] == true }
        end

        rule(:demographic) do
          if key? && value
            if value.is_a?(Hash)
              result = DemographicContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid demographic information', error: result.errors.to_h)
              else
                values.merge!(demographic: result.to_h)
              end
            else
              key.failure(text: 'invalid demographic information. Expected a hash.')
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

        rule(:identifying_numbers_from_documents) do
          if key? && value
            infd_array = value.inject([]) do |hash_array, infd_hash|
              if infd_hash.is_a?(Hash)
                result = IdentifyingNumbersFromDocumentContract.new.call(infd_hash)
                if result&.failure?
                  key.failure(text: 'invalid identifying_numbers_from_documents.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid identifying_numbers_from_documents. Expected a hash.')
              end
              hash_array
            end
            values.merge!(identifying_numbers_from_documents: infd_array)
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

        rule(:immigration_document) do
          if key? && value
            if value.is_a?(Hash)
              result = ImmigrationDocumentContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid immigration_document', error: result.errors.to_h)
              else
                values.merge!(immigration_document: result.to_h)
              end
            else
              key.failure(text: 'invalid immigration_document. Expected a hash.')
            end
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

        rule(:employer_sponsored_insurance_information) do
          if key? && value
            if value.is_a?(Hash)
              result = EmployerSponsoredInsuranceInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid employer_sponsored_insurance_information', error: result.errors.to_h)
              else
                values.merge!(employer_sponsored_insurance_information: result.to_h)
              end
            else
              key.failure(text: 'invalid employer_sponsored_insurance_information. Expected a hash.')
            end
          end
        end

        rule(:lowest_cost_plan) do
          if key? && value
            if value.is_a?(Hash)
              result = LowestCostPlanContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid lowest_cost_plan', error: result.errors.to_h)
              else
                values.merge!(lowest_cost_plan: result.to_h)
              end
            else
              key.failure(text: 'invalid lowest_cost_plan. Expected a hash.')
            end
          end
        end

        rule(:current_income) do
          if key? && value
            if value.is_a?(Hash)
              result = CurrentIncomeContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid current_income', error: result.errors.to_h)
              else
                values.merge!(current_income: result.to_h)
              end
            else
              key.failure(text: 'invalid current_income. Expected a hash.')
            end
          end
        end

        rule(:ssa_income_information) do
          if key? && value
            if value.is_a?(Hash)
              result = SsaIncomeInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid ssa_income_information', error: result.errors.to_h)
              else
                values.merge!(ssa_income_information: result.to_h)
              end
            else
              key.failure(text: 'invalid ssa_income_information. Expected a hash.')
            end
          end
        end

        rule(:ssa_information) do
          if key? && value
            if value.is_a?(Hash)
              result = SsaInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid ssa_information', error: result.errors.to_h)
              else
                values.merge!(ssa_information: result.to_h)
              end
            else
              key.failure(text: 'invalid ssa_information. Expected a hash.')
            end
          end
        end

        rule(:ssa_work_quarters) do
          if key? && value
            ssa_work_quarters_array = value.inject([]) do |hash_array, ssa_work_quarter_hash|
              if ssa_work_quarter_hash.is_a?(Hash)
                result = SsaWorkQuarterContract.new.call(ssa_work_quarter_hash)
                if result&.failure?
                  key.failure(text: 'invalid ssa_work_quarter.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid ssa_work_quarter. Expected a hash.')
              end
              hash_array
            end
            values.merge!(ssa_work_quarters: ssa_work_quarters_array)
          end
        end

        rule(:medicaid_specific_information) do
          if key? && value
            if value.is_a?(Hash)
              result = MedicaidSpecificInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid medicaid_specific_information', error: result.errors.to_h)
              else
                values.merge!(medicaid_specific_information: result.to_h)
              end
            else
              key.failure(text: 'invalid medicaid_specific_information. Expected a hash.')
            end
          end
        end

        rule(:other_insurance_coverage_information) do
          if key? && value
            if value.is_a?(Hash)
              result = OtherInsuranceCoverageInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid other_insurance_coverage_information', error: result.errors.to_h)
              else
                values.merge!(other_insurance_coverage_information: result.to_h)
              end
            else
              key.failure(text: 'invalid other_insurance_coverage_information. Expected a hash.')
            end
          end
        end

        rule(:other_insurance_details) do
          if key? && value
            other_insurance_details_array = value.inject([]) do |hash_array, other_insurance_detail_hash|
              if other_insurance_detail_hash.is_a?(Hash)
                result = OtherInsuranceDetailContract.new.call(other_insurance_detail_hash)
                if result&.failure?
                  key.failure(text: 'invalid other_insurance_detail.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid other_insurance_detail. Expected a hash.')
              end
              hash_array
            end
            values.merge!(other_insurance_details: other_insurance_details_array)
          end
        end

        rule(:person_description_identifiers) do
          if key? && value
            person_description_identifiers_array = value.inject([]) do |hash_array, person_description_identifier_hash|
              if person_description_identifier_hash.is_a?(Hash)
                result = PersonDescriptionIdentifierContract.new.call(person_description_identifier_hash)
                if result&.failure?
                  key.failure(text: 'invalid person_description_identifier.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid person_description_identifier. Expected a hash.')
              end
              hash_array
            end
            values.merge!(person_description_identifiers: person_description_identifiers_array)
          end
        end

        rule(:attestation) do
          if key? && value
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
        end

        rule(:dhs_save) do
          if key? && value
            if value.is_a?(Hash)
              result = DhsSaveContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid dhs_save', error: result.errors.to_h)
              else
                values.merge!(dhs_save: result.to_h)
              end
            else
              key.failure(text: 'invalid dhs_save. Expected a hash.')
            end
          end
        end

        rule(:coverage_specific_information) do
          if key? && value
            if value.is_a?(Hash)
              result = CoverageSpecificInformationContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid coverage_specific_information', error: result.errors.to_h)
              else
                values.merge!(coverage_specific_information: result.to_h)
              end
            else
              key.failure(text: 'invalid coverage_specific_information. Expected a hash.')
            end
          end
        end

        rule(:coverage_period) do
          if key? && value
            if value.is_a?(Hash)
              result = CoveragePeriodContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid coverage_period', error: result.errors.to_h)
              else
                values.merge!(coverage_period: result.to_h)
              end
            else
              key.failure(text: 'invalid coverage_period. Expected a hash.')
            end
          end
        end

        rule(:relationships) do
          if key? && value
            relationships_array = value.inject([]) do |hash_array, relationship_hash|
              if relationship_hash.is_a?(Hash)
                result = RelationshipContract.new.call(relationship_hash)
                if result&.failure?
                  key.failure(text: 'invalid relationship.', error: result.errors.to_h)
                else
                  hash_array << result.to_h
                end
              else
                key.failure(text: 'invalid relationship. Expected a hash.')
              end
              hash_array
            end
            values.merge!(relationships: relationships_array)
          end
        end

        rule(:foster_care) do
          if key? && value
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

        rule(:basis_for_outcome) do
          if key? && value
            if value.is_a?(Hash)
              result = BasisForOutcomeContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid basis_for_outcome', error: result.errors.to_h)
              else
                values.merge!(basis_for_outcome: result.to_h)
              end
            else
              key.failure(text: 'invalid basis_for_outcome. Expected a hash.')
            end
          end
        end
        # rubocop:enable Metrics/ClassLength
      end
    end
  end
end
