# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for OtherInsuranceInformation.
    class OtherInsuranceInformationContract < Dry::Validation::Contract

      params do
        optional(:lost_insurance_within_waiting_period).maybe(:bool)
        optional(:coverage_ended_reason_code).maybe(Types::CoverageEndedReasonCode)
        optional(:enrolled_in_other_insurance).maybe(:bool)
        optional(:has_access_to_state_employee_health_plan).maybe(:bool)
      end
    end
  end
end
