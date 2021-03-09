# frozen_string_literal: true

module AcaEntities
  module PaymentTransactions
    module Contracts

      Dry::Validation.load_extensions(:monads)
      
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
end