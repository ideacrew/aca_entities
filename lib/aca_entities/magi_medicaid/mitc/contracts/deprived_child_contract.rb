# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::DeprivedChild}
        class DeprivedChildContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :qualify_as_deprived_child required
          # @return [Dry::Monads::Result]
          params do
            required(:qualify_as_deprived_child).filled(Types::YesNoKind)
          end
        end
      end
    end
  end
end
