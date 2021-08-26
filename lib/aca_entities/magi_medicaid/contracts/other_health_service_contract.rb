# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::OtherHealthService}
      class OtherHealthServiceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Bool] :has_received optional
        # @option opts [Bool] :is_eligible optional
        # @return [Dry::Monads::Result]
        params do
          optional(:has_received).maybe(:bool)
          optional(:is_eligible).maybe(:bool)
        end
      end
    end
  end
end