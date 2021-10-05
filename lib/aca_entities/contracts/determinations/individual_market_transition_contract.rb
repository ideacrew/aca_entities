# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Determinations
      # # Schema and validation rules for {AcaEntities::Determinations:: IndividualMarketTransition}
      class IndividualMarketTransitionContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :role_type required
        # @option opts [Date] :start_on optional
        # @option opts [Date] :end_on optional
        # @option opts [String] :reason_code optional
        # @option opts [Date] :submitted_at optional
        # @return [Dry::Monads::Result]
        params do
          required(:role_type).filled(AcaEntities::Types::MarketTransitionRoleTypes)
          optional(:start_on).maybe(:date)
          optional(:end_on).maybe(:date)
          required(:reason_code).filled(AcaEntities::Types::MarketTransitionReasonCodes)
          required(:submitted_at).value(:date_time)
        end
      end
    end
  end
end

