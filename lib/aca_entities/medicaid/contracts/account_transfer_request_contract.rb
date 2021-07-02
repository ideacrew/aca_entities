# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for AccountTransferRequest.
      class AccountTransferRequestContract < Dry::Validation::Contract

        params do   
          required(:transfer_header).filled(:hash)
          required(:insurance_application).filled(:hash)
          required(:medicaid_households).filled(:array)
          required(:people).filled(:array)
          required(:senders).filled(:array)
          required(:receivers).filled(:array)

          required(:physical_households).array(:hash) do
             required(:household_size_quantity).filled(:integer)
             required(:household_member_reference).array(:integer)
          end
        end
      end
    end
  end
end
