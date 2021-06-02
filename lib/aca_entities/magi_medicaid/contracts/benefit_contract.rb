# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Benefit}
      class BenefitContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :name optional
        # @option opts [String] :kind required
        # @option opts [String] :status required
        # @option opts [Boolean] :is_employer_sponsored optional
        # @option opts [Hash] :employer optional
        # @option opts [String] :esi_covered optional
        # @option opts [Boolean] :is_esi_waiting_period optional
        # @option opts [Boolean] :is_esi_mec_met optional
        # @option opts [Float] :employee_cost optional
        # @option opts [String] :employee_cost_frequency optional
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @option opts [DateTime] :submitted_at optional
        # @option opts [Symbol] :hra_kind optional
        # @return [Dry::Monads::Result]
        params do
          # title
          optional(:name).maybe(:string)
          # insurance_kind
          required(:kind).filled(Types::BenefitKind)
          # kind
          required(:status).filled(Types::BenefitStatusKind)
          optional(:is_employer_sponsored).maybe(:bool)
          optional(:employer).maybe(EmployerContract.params)
          optional(:esi_covered).maybe(Types::EsiCoveredKind)
          optional(:is_esi_waiting_period).maybe(:bool)
          optional(:is_esi_mec_met).maybe(:bool)
          optional(:employee_cost).maybe(Types::Money)
          optional(:employee_cost_frequency).maybe(Types::EmployeeCostFrequency)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:submitted_at).maybe(:date_time)

          optional(:hra_kind).maybe(Types::HraKind)
        end
      end
    end
  end
end
