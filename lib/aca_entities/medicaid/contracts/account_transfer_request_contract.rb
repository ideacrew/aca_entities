# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for AccountTransferRequest.
      class AccountTransferRequestContract < Dry::Validation::Contract

        params do
          optional(:version).maybe(:string)
          required(:transfer_header).filled(:hash)
          required(:insurance_application).filled(:hash)
          required(:people).array(:hash)
          required(:senders).filled(:array)
          required(:receivers).filled(:array)
          optional(:medicaid_households).array(:hash)
          optional(:assister).maybe(:hash)
          optional(:authorized_representative).maybe(:hash)
          required(:physical_households).value(:array, min_size?: 1)
          optional(:tax_returns).array(:hash)
          optional(:verification_metadata).array(:hash)
        end
      end
    end
  end
end