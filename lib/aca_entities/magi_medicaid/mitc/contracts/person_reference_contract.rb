# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::PersonReference}
        class PersonReferenceContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :person_id required
          # @return [Dry::Monads::Result]
          params do
            required(:person_id).filled(:string)
          end
        end
      end
    end
  end
end
