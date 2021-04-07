# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Families
      # Schema and validation rules for {AcaEntities::Families::FamilyMember}
      class FamilyMemberContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hbx_id required
        # @option opts [Boolean] :is_primary_applicant required
        # @option opts [Boolean] :is_consent_applicant optional
        # @option opts [Boolean] :is_coverage_applicant optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Hash] :applicant optional
        # @option opts [Hash] :former_family optional
        # @option opts [Array] :hbx_enrollment_exemptions optional
        # @option opts [Hash] :person required
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).filled(:string)  #TODO: until hbx_id added to family this is person hbx_id
          required(:is_primary_applicant).filled(:bool)
          optional(:is_consent_applicant).maybe(:bool)
          optional(:is_coverage_applicant).maybe(:bool)
          optional(:is_active).maybe(:bool)

          optional(:applicant).maybe(:hash)
          optional(:former_family).maybe(:hash)
          optional(:hbx_enrollment_exemptions).maybe(:array)
          required(:person).filled(:hash)
          optional(:timestamp).maybe(:hash)
        end

        rule(:applicant) do
          if key? && value
            if value.is_a?(Hash)
              result = MagiMedicaid::Contracts::ApplicantReferenceContract.new.call(value)
              key.failure(text: "invalid applicant", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid applicant. Expected a hash.")
            end
          end
        end

        rule(:former_family) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyReferenceContract.new.call(value)
              key.failure(text: "invalid former family", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid former family. Expected a hash.")
            end
          end
        end

        rule(:hbx_enrollment_exemptions).each do
          if key? && value
            if value.is_a?(Hash)
              result =  AcaEntities::Contracts::Enrollments::HbxEnrollmentExemptionContract.new.call(value)
              key.failure(text: "invalid hbx enrollment exemption", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid hbx enrollment exemption. Expected a hash.")
            end
          end
        end

        rule(:person) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::People::PersonContract.new.call(value)
              key.failure(text: "invalid person", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid person. Expected a hash.")
            end
          end
        end

        rule(:timestamp) do
          if key? && value
            if value.is_a?(Hash)
              result = TimeStampContract.new.call(value)
              key.failure(text: "invalid timestamp", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid timestamp. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
