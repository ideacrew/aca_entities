# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for RefugeeMedicalAssistanceBasis
      class RefugeeMedicalAssistanceBasisContract < Dry::Validation::Contract

        params do
          required(:status_code).filled(:string)
          optional(:status_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
          optional(:medical_assistance_end_date).maybe(:date)
        end
      end
    end
  end
end
