# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for MedicaidMagiEligibility
      class MedicaidMagiEligibilityContract < Dry::Validation::Contract

        params do
          optional(:date_range).maybe(:hash)
          optional(:eligibility_determination).maybe(:hash)
          optional(:eligibility_indicator).maybe(:bool)
          optional(:eligibility_reason_text).maybe(:string)
          optional(:income_eligibility_basis).maybe(:hash)
        end
      end
    end
  end
end
