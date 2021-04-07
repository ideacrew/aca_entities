# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Enrollments
      # Schema and validation rules for {AcaEntities::Enrollments::HbxEnrollment}
      class HbxEnrollmentExemptionContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [String] :certificate_number required
        # @option opts [Date] :start_date required
        # @option opts [Date] :end_date required
        # @option opts [Hash] :family_member required
        # @option opts [Hash] :irs_group required
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(
            AcaEntities::Types::EnrollmentExemptionKinds
          )
          optional(:certificate_number).maybe(:string)
          optional(:start_date).maybe(:date)
          optional(:end_date).maybe(:date)
          optional(:family_member).maybe(:hash)
          optional(:irs_group).maybe(:hash)
        end

        rule(:family_member) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Families::FamilyMemberReferenceContract.new.call(value)
              key.failure(text: "invalid family member", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid family member. Expected a hash.")
            end
          end
        end

        rule(:irs_group) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Groups::IrsGroupReferenceContract.new.call(value)
              key.failure(text: "invalid irs_group", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid irs group. Expected a hash.")
            end
          end
        end
      end
    end
  end
end
