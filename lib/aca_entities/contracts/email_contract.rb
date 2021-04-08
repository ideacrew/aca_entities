# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Email.
    class EmailContract < Dry::Validation::Contract

      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

      params do
        required(:kind).filled(Types::EmailKind)
        required(:address).filled(:string)
      end

      rule(:address) do
        key.failure(text: 'invalid email address.') if value && !value.match?(VALID_EMAIL_REGEX)
      end
    end
  end
end
