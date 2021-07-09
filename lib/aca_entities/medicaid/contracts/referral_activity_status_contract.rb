# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # ReferralActivityStatus contract
      class ReferralActivityStatusContract < Dry::Validation::Contract
        params do
          required(:status_code).filled(:string)
          optional(:overall_verification_status_code).maybe(:string)
          # optiona(:valid_date_range).maybe(:hash)
        end
      end
    end
  end
end