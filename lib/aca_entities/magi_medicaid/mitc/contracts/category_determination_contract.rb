# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::CategoryDetermination}
        class CategoryDeterminationContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :indicator_code required
          # @option opts [Integer] :ineligibility_code required
          # @option opts [String] :ineligibility_reason optional
          # @return [Dry::Monads::Result]
          params do
            required(:category).filled(Types::CategoryDeterminationKind)
            required(:indicator_code).filled(Types::DeterminationIndicatorKind)
            optional(:ineligibility_code).maybe(:integer)
            optional(:ineligibility_reason).maybe(:string)
          end
        end
      end
    end
  end
end
