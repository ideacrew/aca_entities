# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Receiver.
      class ReceiverContract < Dry::Validation::Contract

        params do
          optional(:recipient_code).maybe(:string)
          optional(:recipient_medicaid_chip_state).maybe(:string)
          optional(:recipient_medicaid_chip_county).maybe(:string)
        end

        # TODO: Fix these rules later
        rule(:recipient_code) do
          # key.failure(text: 'Recipient Code is invalid') if key? && value
        end

        # Required if Recipient is not Exchange and Referral Header exists
        # TODO: Fix these rules later
        rule(:recipient_medicaid_chip_state) do
          # key.failure(text: 'Recipient Medicaid CHIP State Code is invalid') if key? && value
        end
      end
    end
  end
end
