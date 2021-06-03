# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::MedicaidHousehold}
        class MedicaidHouseholdContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Array] :people required
          # @option opts [Integer] :magi_income required
          # @option opts [Integer] :size required
          # @return [Dry::Monads::Result]
          params do
            required(:people).array(:integer)
            required(:magi_income).filled(:integer)
            required(:magi_as_percentage_of_fpl).filled(:integer)
            required(:size).filled(:integer)
          end
        end
      end
    end
  end
end
