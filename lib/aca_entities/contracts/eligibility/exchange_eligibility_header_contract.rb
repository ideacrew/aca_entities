# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for ExchangeEligibilityHeader
      class ExchangeEligibilityHeaderContract < Dry::Validation::Contract

        params do
          required(:start_date).filled(:date)
          required(:medicaid_chip_state).filled(:string)
          optional(:eligibility_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:end_date).maybe(:date)
          optional(:medicaid_chip_county).maybe(:string)
          optional(:eligibility_establishment_system).maybe(:string)
        end
      end
    end
  end
end
