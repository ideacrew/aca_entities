# frozen_string_literal: true

# Validates the presence of params and type of effective date.
module AcaEntities
  # Contract for transaction params
  module Contracts

    Dry::Validation.load_extensions(:monads)
    # Transaction contract
    class TransactionContract < ::Dry::Validation::Contract

      params do
        required(:enrollment_id).value(:string)
        required(:carrier_id).value(:string)
        required(:enrollment_effective_date).value(:date)
      end

      rule(:enrollment_id) do
        key.failure('Enrollment id is blank') if value.empty?
      end

      rule(:carrier_id) do
        key.failure('Carrier id is blank') if value.empty?
      end

      rule(:enrollment_effective_date) do
        key.failure('Enrollment effective on is not a date') unless value.is_a?(Date)
      end
    end
  end
end