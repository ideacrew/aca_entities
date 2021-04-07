# frozen_string_literal: true

# Validates the presence of params and type of effective date.
module AcaEntities
  # Contract for transaction params
  module Contracts
    # Financial namescape for contracts
    module Financial
      # Payment Transactions
      module PaymentTransactions
        Dry::Validation.load_extensions(:monads)
        # Schema and validation rules for {AcaEntities::Financial::PaymentTransactions::PaymentTransaction}
        class PaymentTransactionContract < ::Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [String] :payment_transaction_id optional
          # @option opts [String] :enrollment_id required
          # @option opts [Hash] :issuer_profile required
          # @option opts [Date] :enrollment_effective_date required
          # @option opts [String] :status optional
          # @return [Dry::Monads::Result]
          params do
            optional(:payment_transaction_id).maybe(:string)
            required(:enrollment_id).value(:string)
            required(:issuer_profile).value(:hash)
            required(:enrollment_effective_date).value(:date)
            optional(:status).maybe(:string)
          end

          rule(:enrollment_id) do
            key.failure('Enrollment id is blank') if value.empty?
          end

          rule(:issuer_profile) do
            if key? && value
              if value.is_a?(Hash)
                result = AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.new.call(value)
                key.failure(text: "invalid issuer profile", error: result.errors.to_h) if result&.failure?
              else
                key.failure(text: "invalid issuer profile. Expected a hash.")
              end
            end
          end

          rule(:enrollment_effective_date) do
            key.failure('Enrollment effective on is not a date') unless value.is_a?(Date)
          end
        end
      end
    end
  end
end