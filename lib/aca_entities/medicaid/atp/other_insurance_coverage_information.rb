# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for OtherInsuranceCoverageInformation.
      class OtherInsuranceCoverageInformation < Dry::Struct

        # Person lost health insurance within the number of months associated with the state waiting period.
        attribute :lost_insurance_within_waiting_period,      Types::Bool.optional.meta(omittable: true)
        attribute :coverage_ended_reason_code,                Types::String.optional.meta(omittable: true)
        attribute :enrolled_in_other_insurance,               Types::Bool.optional.meta(omittable: true)
        attribute :has_access_to_state_employee_health_plan,  Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
