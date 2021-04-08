# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Email.
    class EmailContract < Dry::Validation::Contract
      params do
        required(:kind).filled(Types::EmailKind)
        required(:address).filled(:string)
      end

      rule(:address) do
        key.failure(text: 'invalid email address.') if value && !value.match?(Types::EmailAddressRegex)
      end
    end
  end
end
