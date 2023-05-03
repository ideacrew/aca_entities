# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmitable
      module Contracts
        # Schema and validation rules for the {AcaEntities::Protocols::Transmitable::Subject} entity
        class SubjectContract < Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Array<AcaEntities::Protocols::Transmitable::Transaction>]: The list of transactions that belong to this subject
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          params do
            required(:transactions).array(AcaEntities::Protocols::Transmitable::Contracts::TransactionContract.params)
          end
        end
      end
    end
  end
end