# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Relationship}
      class RelationshipContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :kind required
        # @option opts [Hash] :applicant_reference required
        # @option opts [Hash] :relative_reference required
        # @option opts [Boolean] :lives_with_household_member optional
        # @return [Dry::Monads::Result]
        params do
          required(:kind).filled(Types::RelationshipKind)
          required(:applicant_reference).filled(ApplicantReferenceContract.params)
          required(:relative_reference).filled(ApplicantReferenceContract.params)
          optional(:lives_with_household_member).maybe(:bool)
        end
      end
    end
  end
end
