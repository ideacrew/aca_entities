# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Household}
        class HouseholdContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :household_id required
          # @option opts [Array] :people required
          # @return [Dry::Monads::Result]
          params do
            required(:household_id).filled(:string)
            required(:people).array(PersonReferenceContract.params)
          end
        end
      end
    end
  end
end
