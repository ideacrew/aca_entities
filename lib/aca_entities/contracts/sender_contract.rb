# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Sender.
    class SenderContract < Dry::Validation::Contract

      params do
        optional(:sender_code).maybe(:string)
        optional(:sender_medicaid_chip_state).maybe(:string)
        optional(:sender_medicaid_chip_county).maybe(:string)
      end

      # TODO: Fix these rules later
      rule(:sender_code) do
        # key.failure(text: 'Sender Code is invalid') if key? && value
      end

      # Required if Sender is not Exchange and Referral Header exists.
      # Also required if Transfer Header Recipient Code is "Exchange".
      # TODO: Fix these rules later
      rule(:sender_medicaid_chip_state) do
        # key.failure(text: 'Sender Medicaid CHIP State Code is invalid') if key? && value
      end
    end
  end
end
