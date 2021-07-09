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
          required(:medicaid_household).filled(:hash)
          required(:people).filled(:hash)
          required(:senders).filled(:array)
          required(:receivers).filled(:array)
          required(:insurance_application).filled(:hash)
          optional(:medicaid_households).maybe(:array)
          # optional(:assister).maybe(:array)
          optional(:authorized_representative).maybe(:array)

          required(:physical_households).value(:array, min_size?: 1).each do
            required(:household_size_quantity).filled(:integer)
            required(:household_member_reference).array(:hash)
          end
        end

        rule(transfer_header.number_of_referrals) do
          #
          # key.failure(text: 'The value of number_of_referrals must equal the number of referal activities elements in the payload.') if key? && value
        end
      end
    end
  end
end