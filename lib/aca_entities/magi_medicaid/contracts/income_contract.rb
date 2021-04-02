# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Income.
      class IncomeContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper

        params do
          optional(:title).maybe(:string)
          required(:kind).filled(Types::IncomeKind)
          optional(:wage_type).maybe(:string)
          optional(:hours_per_week).maybe(:integer)
          required(:amount).filled(:float)
          optional(:amount_tax_exempt).maybe(:float)
          required(:frequency_kind).filled(Types::IncomeFrequency)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:is_projected).maybe(:bool)
          optional(:employer).maybe(:hash)
          optional(:has_property_usage_rights).maybe(:bool)
          optional(:submitted_at).maybe(:date_time)
        end

        rule(:employer) do
          if key? && check_if_present?(value) && value.is_a?(Hash)
            result = EmployerContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid employer.', error: result.errors.to_h)
            else
              values.merge!(employer: result.to_h)
            end
          end
        end

        rule(:end_on) do
          key.failure(text: 'must be after start_on.') if key? && check_if_present?(value) && values[:start_on] && value < values[:start_on]
        end
      end
    end
  end
end
