# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::ParentCaretakerRelationship}
        class ParentCaretakerRelationshipContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :qualify_for_parent_caretaker_status optional
          # @return [Dry::Monads::Result]
          params do
            optional(:qualify_for_parent_caretaker_status).filled(Types::YesNoKind)
          end
        end
      end
    end
  end
end
