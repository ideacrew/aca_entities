# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for EmergencyMedicaidIncomeBasis
      class EmergencyMedicaidIncomeBasisContract < Dry::Validation::Contract

        params do
          required(:medicaid_status_code).filled(:string)
          optional(:medicaid_status_indicator).maybe(:bool)
          optional(:medicaid_inconsistency_reason).maybe(:string)
          optional(:medicaid_ineligibility_reason).maybe(:string)
          optional(:medicaid_status_determination_date).maybe(:date_time)
        end
      end
    end
  end
end
