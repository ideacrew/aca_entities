# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # ReferralActivityReceiverrReference contract
      class ReferralActivityReceiverReferenceContract < Dry::Validation::Contract
        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end