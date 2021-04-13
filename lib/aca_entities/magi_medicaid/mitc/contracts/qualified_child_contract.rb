# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::QualifiedChild}
        class QualifiedChildContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :person_id required
          # @option opts [Hash] :determination required
          # @option opts [Hash] :deprived_child required
          # @option opts [Hash] :relationship required
          # @return [Dry::Monads::Result]
          params do
            required(:person_id).filled(:integer)
            required(:determination).hash(CategoryDeterminationContract.params)
            required(:deprived_child).hash(DeprivedChildContract.params)
            required(:relationship).hash(RelationshipContract.params)
          end
        end
      end
    end
  end
end
