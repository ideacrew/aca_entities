# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Benefit.
      class BenefitContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          # title
          optional(:name).maybe(:string)
          # insurance_kind
          required(:kind).filled(Types::BenefitKind)
          # kind
          required(:status).filled(Types::BenefitStatusKind)
          optional(:is_employer_sponsored).maybe(:bool)
          optional(:employer).maybe(:hash)
          optional(:esi_covered).maybe(Types::EsiCoveredKind)
          optional(:is_esi_waiting_period).maybe(:bool)
          optional(:is_esi_mec_met).maybe(:bool)
          optional(:employee_cost).maybe(:float)
          optional(:employee_cost_frequency).maybe(Types::EmployeeCostFrequency)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          optional(:submitted_at).maybe(:date_time)
        end

        rule(:employer) do
          if kind_esi?(values[:kind]) && key? && value
            if value.is_a?(Hash)
              result = EmployerContract.new.call(value)
              if result&.failure?
                key.failure(text: 'invalid employer.', error: result.errors.to_h)
              else
                values.merge!(employer: result.to_h)
              end
            else
              key.failure(text: 'invalid employer. Expected a hash.')
            end
          elsif kind_esi?(values[:kind])
            key.failure(text: 'employer information missing for kind employer_sponsored_insurance.')
          end
        end

        rule(:esi_covered) do
          key.failure(text: 'is expected when kind is employer_sponsored_insurance.') if key? && check_if_blank?(value) && kind_esi?(values[:kind])
        end

        rule(:start_on) do
          if check_if_blank?(value) && (kind_esi?(values[:kind]) || status_enrolled?(values[:status]))
            key.failure(text: 'is expected when kind is employer_sponsored_insurance or status is is_enrolled.')
          end
        end

        rule(:employee_cost_frequency) do
          key.failure(text: 'is expected when kind is employer_sponsored_insurance.') if key? && check_if_blank?(value) && kind_esi?(values[:kind])
        end

        rule(:employee_cost) do
          key.failure(text: 'is expected when kind is employer_sponsored_insurance.') if key? && check_if_blank?(value) && kind_esi?(values[:kind])
        end

        rule(:end_on) do
          key.failure(text: 'must be after start_on.') if key? && check_if_present?(value) && values[:start_on] && value < values[:start_on]
        end

        def kind_esi?(kind_value)
          kind_value == 'employer_sponsored_insurance'
        end

        def status_enrolled?(status_value)
          status_value == 'is_enrolled'
        end
      end
    end
  end
end
