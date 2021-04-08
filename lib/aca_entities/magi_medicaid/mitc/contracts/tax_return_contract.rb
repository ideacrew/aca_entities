# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::TaxReturn}
        class TaxReturnContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Hash] :filers required
          # @option opts [Hash] :dependents required
          # @return [Dry::Monads::Result]
          params do
            required(:filers).array(PersonReferenceContract.params)
            required(:dependents).array(PersonReferenceContract.params)
          end
        end
      end
    end
  end
end
