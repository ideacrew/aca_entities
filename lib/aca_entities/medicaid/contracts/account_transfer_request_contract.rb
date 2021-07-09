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
          required(:people).filled(:hash)
          required(:senders).filled(:array)
          required(:receivers).filled(:array)
          required(:insurance_application).filled(:hash)
          optional(:medicaid_households).maybe(:array)
          # optional(:assister).maybe(:array)
          optional(:authorized_representative).maybe(:array)
          required(:physical_households).value(:array, min_size?: 1)
        end

        rule(:physical_households).each do
          key.failure('household_size_quantity is required') unless value[:household_size_quantity]
          key.failure('household_member_reference is required') unless value[:household_member_reference]
        end
      end
    end
  end
end