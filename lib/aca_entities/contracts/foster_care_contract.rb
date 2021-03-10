# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for FosterCare.
    class FosterCareContract < Dry::Validation::Contract

      params do
        optional(:attested_foster_care).filled(:bool)
        optional(:age_left_foster_care).filled(:integer)
        optional(:foster_care_us_state_code).filled(:string)
        optional(:had_medicaid_during_foster_care).filled(:bool)
      end
    end
  end
end
