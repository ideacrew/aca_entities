# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for TransferHeader.
      class TransferHeaderContract < Dry::Validation::Contract

        params do
          required(:transfer_activity).filled(:hash)
          optional(:recipient_state_code).maybe(:string)
        end

      end
    end
  end
end