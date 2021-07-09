# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Referral activity contract
      class ReferralActivityContract < Dry::Validation::Contract
        params do
          required(:activity_id).filled(:hash)
          required(:activity_date).filled(:hash)
          required(:sender_reference).filled(:hash)
          required(:receiver_reference).filled(:hash)
          optional(:activity_identification).maybe(:hash)
          optional(:reason_code).maybe(:string)
          required(:status).filled(:hash)
          # optional(:eligibility_reason_reference).maybe(:hash)
        end
      end
    end
  end
end