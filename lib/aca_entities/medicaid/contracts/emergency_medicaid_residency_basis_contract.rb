# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # contract for EmergencyMedicaidResidencyBasis
      class EmergencyMedicaidResidencyBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:ineligibility_reason).maybe(:string)
          optional(:determination_date).maybe(:date_time)
          optional(:pend_reason).maybe(:string)
        end
      end
    end
  end
end
