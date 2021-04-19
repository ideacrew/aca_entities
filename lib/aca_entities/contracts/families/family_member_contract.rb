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
        # @option opts [Array] :foreign_keys optional
        # @option opts [Boolean] :is_consent_applicant optional
        # @option opts [Boolean] :is_coverage_applicant optional
        # @option opts [Boolean] :is_active optional
        # @option opts [Hash] :magi_medicaid_application_applicants optional
        # @option opts [Hash] :former_family optional
        # @option opts [Hash] :person required
        # @option opts [Hash] :timestamp optional
        # @return [Dry::Monads::Result]
        params do
          optional(:hbx_id).filled(:string)
          required(:is_primary_applicant).value(:bool?)
          optional(:foreign_keys).array(AcaEntities::Contracts::Identifiers::IdContract.params)
          optional(:is_consent_applicant).maybe(:bool)
          optional(:is_coverage_applicant).maybe(:bool)
          optional(:is_active).maybe(:bool)
          optional(:magi_medicaid_application_applicants).array(MagiMedicaid::Contracts::ApplicantReferenceContract.params)
          required(:person).hash(AcaEntities::Contracts::People::PersonContract.params)
          optional(:timestamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
