# frozen_string_literal: true

module Ehs::Addresses
  # Schema and validation rules for {Ehs::Addresses::Address} domain object
  class AddressContract < Ehs::ApplicationContract
    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] :type (required)
    # @option opts [String] :line_1 (required)
    # @option opts [String] :line_2 (optional)
    # @option opts [String] :city (required)
    # @option opts [Ehs::Types::UsStateKind] :state (required)
    # @option opts [String] :zip (required)
    # @return [Dry::Monads::Result] Success or Failure
    params do
      required(:type).filled(Ehs::Types::AddressKind)
      required(:line_1).filled(:string)
      optional(:line_2).maybe(:string)
      required(:city).filled(:string)
      required(:state).filled(Ehs::Types::UsStateKind)
      required(:zip).filled(:string)
    end
  end
end
