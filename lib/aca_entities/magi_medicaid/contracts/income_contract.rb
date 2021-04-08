# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Income}
      class IncomeContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :title optional
        # @option opts [String] :kind required
        # @option opts [String] :wage_type optional
        # @option opts [Integer] :hours_per_week optional
        # @option opts [Float] :amount optional
        # @option opts [Float] :amount_tax_exempt optional
        # @option opts [String] :frequency_kind required
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [Boolean] :is_projected optional
        # @option opts [Hash] :employer optional
        # @option opts [Boolean] :has_property_usage_rights optional
        # @option opts [DateTime] :submitted_at optional
        # @return [Dry::Monads::Result]
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
          optional(:employer).maybe(EmployerContract.params)
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
