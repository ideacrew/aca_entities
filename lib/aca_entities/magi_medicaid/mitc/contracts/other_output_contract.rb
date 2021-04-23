# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::OtherOutput}
        class OtherOutputContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Array] :qualified_children_list optional
          # @return [Dry::Monads::Result]
          params do
            optional(:qualified_children_list).array(QualifiedChildContract.params)
          end
        end
      end
    end
  end
end
