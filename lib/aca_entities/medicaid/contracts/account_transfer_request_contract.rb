# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for AccountTransferRequest.
      class AddressAccountTransferRequest < Dry::Validation::Contract

        params do
          required(:transfer_header).filled(:hash)
          required(:insurance_application).filled(:hash)
          required(:medicaid_household).filled(:hash)
          required(:person).filled(:hash)
          required(:sender).filled(:array)
          required(:receiver).filed(:array)

          required(:physical_household).array(:hash) do
            required(:household_size_quantity).filled(:integer)
            required(:household_member_reference).array(:integer)
          end
        end
      end
    end
  end
end
