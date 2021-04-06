# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Email.
    class EmailContract < Dry::Validation::Contract

      params do
        required(:kind).filled(Types::EmailKind)
        required(:address).filled(:string)
      end
    end
  end
end
