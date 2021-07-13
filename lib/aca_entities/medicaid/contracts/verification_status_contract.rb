# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Verification status information contract
      class VerificationStatusContract < Dry::Validation::Contract
        params do
          required(:status).filled(:string)
        end
      end
    end
  end
end