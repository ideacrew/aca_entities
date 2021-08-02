# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # ReferralActivitySenderReference contract
      class ReferralActivitySenderReferenceContract < Dry::Validation::Contract
        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end