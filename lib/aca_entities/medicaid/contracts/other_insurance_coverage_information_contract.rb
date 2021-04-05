# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for OtherInsuranceCoverageInformation.
      class OtherInsuranceCoverageInformationContract < Dry::Validation::Contract

        params do
          optional(:lost_insurance_within_waiting_period).maybe(:bool)
          optional(:coverage_ended_reason_code).maybe(Types::CoverageEndedReasonCode)
          optional(:enrolled_in_other_insurance).maybe(:bool)
          optional(:has_access_to_state_employee_health_plan).maybe(:bool)
        end

        rule(:lost_insurance_within_waiting_period) do
          if key?
            # required when CHIP eligible
          end
        end
      end
    end
  end
end
