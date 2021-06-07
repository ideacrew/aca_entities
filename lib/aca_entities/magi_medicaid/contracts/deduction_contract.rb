# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Deduction}
      class DeductionContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :name optional
        # @option opts [String] :kind required
        # @option opts [Float] :amount required
        # @option opts [Date] :start_on required
        # @option opts [Date] :end_on optional
        # @option opts [String] :frequency_kind required
        # @option opts [DateTime] :submitted_at optional
        # @return [Dry::Monads::Result]
        params do
          optional(:name).maybe(:string)
          required(:kind).filled(Types::DeductionKind)
          required(:amount).filled(Types::Money)
          required(:start_on).filled(:date)
          optional(:end_on).maybe(:date)
          required(:frequency_kind).filled(Types::DeductionFrequency)
          optional(:submitted_at).maybe(:date_time)
        end
      end
    end
  end
end
