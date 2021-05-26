# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::MedicaidCubcare}
      class MedicaidCubcareContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Bool] :not_eligible_in_last_90_days required
        # @option opts [Date] :denied_on optional
        # @option opts [Bool] :ended_as_change_in_eligibility optional
        # @option opts [Bool] :hh_income_or_size_changed optional
        # @option opts [Date] :medicaid_or_chip_coverage_end_date optional
        # @option opts [Bool] :ineligible_due_to_immigration_in_last_5_years optional
        # @option opts [Bool] :immigration_status_changed_since_ineligibility optional
        # @return [Dry::Monads::Result]
        params do
          required(:not_eligible_in_last_90_days).filled(:bool)
          optional(:denied_on).maybe(:date)
          optional(:ended_as_change_in_eligibility).maybe(:bool)
          optional(:hh_income_or_size_changed).maybe(:bool)
          optional(:medicaid_or_chip_coverage_end_date).maybe(:date)
          optional(:ineligible_due_to_immigration_in_last_5_years).maybe(:bool)
          optional(:immigration_status_changed_since_ineligibility).maybe(:bool)
        end
      end
    end
  end
end