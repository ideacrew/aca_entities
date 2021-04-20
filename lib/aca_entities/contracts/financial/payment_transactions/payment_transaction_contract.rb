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
            required(:enrollment_id).filled(:string)
            required(:carrier_id).filled(:string)
            # TODO: Needs refactor
            # required(:issuer_profile_reference).hash(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)
            required(:enrollment_effective_date).filled(:date)

            optional(:status).maybe(:string)
            optional(:payment_transaction_id).maybe(:string)
            required(:source).value(:string)
          end
        end
      end
    end
  end
end