# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::DependentAge}
        class DependentAgeContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :is_person_of_dependent_age required
          # @return [Dry::Monads::Result]
          params do
            required(:is_person_of_dependent_age).filled(Types::YesNoKind)
          end
        end
      end
    end
  end
end
