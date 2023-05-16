# frozen_string_literal: true

module AcaEntities
  module Protocols
    module Transmittable
      module Contracts
        # A schema to validate {AcaEntities::Protocols::Transmittable::Contracts::Transaction Transactions} that
        # belong to a subject Entity.
        # @example Usage
        #
        # params do
        #   required(:id).filled(:string)
        #   required(:name).filled(:symbol)
        #   required(:title).filled(:string)
        #   required(:description).filled(:string)
        #   required(:subject_transactions).schema(AcaEntities::Protocols::Transmittable::Contracts::SubjectContract.new)
        # end
        class SubjectContract < Dry::Schema::Params
          # @!method call(params)
          # @param [Hash] params the parameters to validate using this contract
          # @option params [Array<AcaEntities::Protocols::Transmittable::Transaction>]: The list of transactions that belong to this subject
          # @return [Dry::Monads::Result::Success] if params pass validation
          # @return [Dry::Monads::Result::Failure] if params fail validation
          define do
            optional(:transactions).array(AcaEntities::Protocols::Transmittable::Contracts::TransactionContract.params)
            # optional(:transactions).maybe(:array).each(AcaEntities::Protocols::Transmittable::Contracts::TransactionContract.params)
          end
        end
      end
    end
  end
end
