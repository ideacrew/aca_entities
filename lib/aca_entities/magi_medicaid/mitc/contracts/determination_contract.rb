# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Determination}
        class DeterminationContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :dependent_age required
          # @return [Dry::Monads::Result]
          params do
            required(:dependent_age).filled(DependentAgeContract.params)
          end
        end
      end
    end
  end
end
