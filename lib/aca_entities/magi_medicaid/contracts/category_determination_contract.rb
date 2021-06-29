# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::CategoryDetermination}
      class CategoryDeterminationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :indicator_code required
        # @option opts [Integer] :ineligibility_code required
        # @option opts [String] :ineligibility_reason optional
        # @return [Dry::Monads::Result]
        params do
          required(:category).filled(::AcaEntities::MagiMedicaid::Mitc::Types::CategoryDeterminationKind)
          # indicator_code should also be able to accept nil. nil means NotApplicable
          required(:indicator_code).maybe(:bool)
          optional(:ineligibility_code).maybe(:integer)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
