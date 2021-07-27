# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Transfer activity information contract
      class TransferActivityContract < Dry::Validation::Contract
        params do
          required(:transfer_id).filled(:hash)
          optional(:transfer_date).maybe(:hash)
          required(:number_of_referrals).filled(:integer)
          required(:recipient_code).filled(:string)
          optional(:state_code).maybe(:string)
        end
      end
    end
  end
end