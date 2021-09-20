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
          required(:medicaid_households).filled(:array)
          required(:people).array(:hash)
          required(:senders).filled(:array)
          required(:receivers).filled(:array)
          required(:insurance_application).filled(:hash)
          optional(:medicaid_households).maybe(:array)
          # optional(:assister).maybe(:array)
          optional(:authorized_representative).maybe(:hash)
          required(:physical_households).value(:array, min_size?: 1)
          optional(:tax_returns).array(:hash)
          # optional(:verification_metadata).maybe(:hash)
          optional(:verification_metadata).array(:hash)
        end
      end
    end
  end
end