# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Referral activity contract
      class ReferralActivityContract < Dry::Validation::Contract
        params do
          required(:sender_reference).filled(:hash)
          required(:receiver_reference).filled(:hash)
          optional(:activity_date).maybe(:hash)
          optional(:activity_identification).maybe(:hash)
          optional(:reason_code).maybe(:string)
          optional(:status).maybe(:hash)
          # optional(:eligibility_reason_reference).maybe(:hash)
        end
      end
    end
  end
end