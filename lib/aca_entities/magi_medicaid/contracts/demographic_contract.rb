# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Demographic}
      class DemographicContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :gender required
        # @option opts [Date] :dob required
        # @option opts [Array] :ethnicity optional
        # @option opts [String] :race optional
        # @option opts [Boolean] :is_veteran_or_active_military optional
        # @option opts [Boolean] :is_vets_spouse_or_child optional
        # @return [Dry::Monads::Result]
        params do
          required(:gender).filled(Types::GenderKind)
          required(:dob).filled(:date)
          optional(:ethnicity).array(:string)
          optional(:race).maybe(:string)
          optional(:is_veteran_or_active_military).maybe(:bool)
          optional(:is_vets_spouse_or_child).maybe(:bool)
        end
      end
    end
  end
end
