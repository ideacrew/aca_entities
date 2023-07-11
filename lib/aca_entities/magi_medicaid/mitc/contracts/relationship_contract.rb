# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Relationship}
        class RelationshipContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :other_id required
          # @option opts [String] :attest_primary_responsibility required
          # @option opts [String] :relationship_code required
          # @return [Dry::Monads::Result]
          params do
            required(:other_id).filled(:string)
            required(:attest_primary_responsibility).filled(Types::YesNoKind)
            required(:relationship_code).filled(Types::RelationshipCodeKind)
          end
        end
      end
    end
  end
end
