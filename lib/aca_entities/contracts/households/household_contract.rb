# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Households
      # Schema and validation rules for {AcaEntities::Households::Household}
      class HouseholdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :start_date required
        # @option opts [Date] :end_date optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Date] :submitted_at optional
        # @option opts [Hash] :irs_group optional
        # @option opts [Hash] :tax_households optional
        # @option opts [Hash] :coverage_households required
        # @option opts [Hash] :hbx_enrollments optional
        # @return [Dry::Monads::Result]
        params do
          required(:start_date).filled(:date)
          optional(:end_date).filled(:date)
          optional(:is_active).filled(:bool)
          optional(:submitted_at).filled(:date)
          optional(:irs_group).filled(:hash)
          optional(:tax_households).filled(:hash)
          required(:coverage_households).filled(:hash)
          optional(:hbx_enrollments).filled(:hash)
        end

        rule(:end_date, :start_date) do
          if values[:end_date]
            key.failure('End on must be after start on date') unless values[:end_date] >= values[:start_date]
          end
        end

        rule(:irs_group) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Group::IrsGroupReferenceContract.new.call(value)
              key.failure(text: "invalid irs group", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid irs group. Expected a hash.")
            end
          end
        end

        rule(:tax_households).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::TaxHouseholdContract.new.call(value)
              key.failure(text: "invalid tax household", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid tax household. Expected a hash.")
            end
          end
        end

        rule(:coverage_households).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Households::CoverageHouseholdContract.new.call(value)
              key.failure(text: "invalid coverage household", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid coverage household. Expected a hash.")
            end
          end
        end

        rule(:hbx_enrollments).each do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Enrollments::HbxEnrollmentContract.new.call(value)
              key.failure(text: "invalid hbx enrollment", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid hbx enrollment. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
