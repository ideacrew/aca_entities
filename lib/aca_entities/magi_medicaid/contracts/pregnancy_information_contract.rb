# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::PregnancyInformation}
      class PregnancyInformationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_pregnant required
        # @option opts [Boolean] :is_enrolled_on_medicaid optional
        # @option opts [Boolean] :is_post_partum_period optional
        # @option opts [Integer] :expected_children_count optional
        # @option opts [Date] :pregnancy_due_on optional
        # @option opts [Date] :pregnancy_end_on optional
        # @return [Dry::Monads::Result]
        params do
          required(:is_pregnant).filled(:bool)
          optional(:is_enrolled_on_medicaid).maybe(:bool)
          optional(:is_post_partum_period).maybe(:bool)
          optional(:expected_children_count).maybe(:integer)
          optional(:pregnancy_due_on).maybe(:date)
          optional(:pregnancy_end_on).maybe(:date)
        end
      end
    end
  end
end