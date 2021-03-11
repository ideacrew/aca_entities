# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for ChipTraffickingVictimBasis
      class ChipTraffickingVictimBasisContract < Dry::Validation::Contract
        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
