# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Identifiers
      # Schema and validation rules for {AcaEntities::Identifiers::Id}
      class IdContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :key required
        # @option opts [String] :item required
        # @option opts [Hash] :kind optional
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @return [Dry::Monads::Result]
        params do
          required(:key).filled(
            AcaEntities::Types::IdKey
          )
          required(:item).filled(:string)
          optional(:kind).hash(AcaEntities::Contracts::Identifiers::IdentifierKindContract.params)
          optional(:start_on).value(:date)
          optional(:end_on).value(:date)
        end
      end
    end
  end
end