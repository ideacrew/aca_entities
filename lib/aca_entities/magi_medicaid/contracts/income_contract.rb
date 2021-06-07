# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Income}
      class IncomeContract < Dry::Validation::Contract
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
          required(:amount).filled(Types::Money)
          optional(:amount_tax_exempt).maybe(Types::Money)
          required(:frequency_kind).filled(Types::IncomeFrequency)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          optional(:is_projected).maybe(:bool)
          optional(:employer).maybe(EmployerContract.params)
          optional(:has_property_usage_rights).maybe(:bool)
          optional(:submitted_at).maybe(:date_time)
        end
      end
    end
  end
end
