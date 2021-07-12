# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Transfer activity information contract
      class TransferActivityContract < Dry::Validation::Contract
        params do
          required(:transfer_id).filled(:hash)
          optional(:transfer_date).maybe(:hash)
          optional(:number_of_referrals).maybe(:integer)
          required(:recipient_code).filled(:string)
          optional(:state_code).maybe(:integer)
        end
      end
    end
  end
end