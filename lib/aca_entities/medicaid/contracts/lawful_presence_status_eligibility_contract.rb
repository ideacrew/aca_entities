# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for LawfulPresenceStatusEligibilityContract
      class LawfulPresenceStatusEligibilityContract < Dry::Validation::Contract
        params do
          required(:eligibility_indicator).filled(:bool)
          optional(:eligibility_basis_status_code).maybe(:string)
        end
      end
    end
  end
end
