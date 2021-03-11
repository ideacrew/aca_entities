# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for MagiHouseholdSizeBasis
      class MagiHouseholdSizeBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:status_determination_date).maybe(:date_time)
          optional(:inconsistency_reason).maybe(:string)
          optional(:ineligibility_reason).maybe(:string)
          optional(:status_source_code).maybe(:string)
        end
      end
    end
  end
end
