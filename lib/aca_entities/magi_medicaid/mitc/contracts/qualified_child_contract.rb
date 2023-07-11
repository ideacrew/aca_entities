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
            required(:person_id).filled(:string)
            required(:determination).hash(DeterminationContract.params)
            required(:deprived_child).hash(DeprivedChildContract.params)
            optional(:parent_caretaker_relationship).hash(ParentCaretakerRelationshipContract.params)
          end
        end
      end
    end
  end
end
