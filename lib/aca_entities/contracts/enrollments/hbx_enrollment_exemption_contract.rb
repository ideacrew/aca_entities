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
          optional(:family_member_reference).hash(AcaEntities::Contracts::Families::FamilyMemberReferenceContract.params)
          optional(:irs_group_reference).hash(AcaEntities::Contracts::Groups::IrsGroupReferenceContract.params)
        end
      end
    end
  end
end
