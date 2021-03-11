# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for ChipHouseholdSizeBasis
      class ChipHouseholdSizeBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:status_determination_date).maybe(:date)
          optional(:ineligibility_reason).maybe(:string)
        end

      end
    end
  end
end
