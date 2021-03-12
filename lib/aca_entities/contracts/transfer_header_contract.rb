# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for TransferHeader.
    class TransferHeaderContract < Dry::Validation::Contract

      params do
        required(:transfer_id).filled(:string)
        required(:transfer_date).filled(:date_time)
        required(:number_of_referrals).filled(:integer)
        required(:recipient_code).filled(:string)
        optional(:medicaid_chip_state).maybe(:string)
      end

      # required if Recipient is not Exchange
      # TODO: Fix this rule later
      rule(:medicaid_chip_state) do
        # key.failure(text: 'Medicaid CHIP State Code is invalid') if key? && value
      end
    end
  end
end
