# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Schema and validation rules for {AcaEntities::Currency}
    class CurrencyContract < Dry::Validation::Contract
      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [Float] :cents required
      # @option opts [String] :currency_iso required
      # @return [Dry::Monads::Result]
      params do
        required(:cents).maybe(AcaEntities::Types::Money)
        required(:currency_iso).value(:str?)
      end
    end
  end
end

