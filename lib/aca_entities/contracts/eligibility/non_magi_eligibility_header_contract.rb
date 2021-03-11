# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for NonMagiEligibilityHeader
      class NonMagiEligibilityHeaderContract < Dry::Validation::Contract

        params do
          required(:start_date).filled(:date)
          required(:medicaid_chip_state).filled(:string)
          optional(:referal_indicator).maybe(:bool)
          optional(:referral_determination_date).maybe(:date_time)
          optional(:referral_ineligibility_reason).maybe(:string)
          optional(:end_date).maybe(:date)
          optional(:medicaid_chip_county).maybe(:string)
          optional(:eligibility_establishment_system).maybe(:string)
        end
      end
    end
  end
end
