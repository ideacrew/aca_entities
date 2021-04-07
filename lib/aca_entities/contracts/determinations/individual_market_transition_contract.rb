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
          required(:role_type).filled(
            AcaEntities::Types::MarketTransitionRoleTypes
          )
          optional(:start_on).filled(:date)
          optional(:end_on).filled(:date)
          required(:reason_code).filled(
            AcaEntities::Types::MarketTransitionReasonCodes
          )
          required(:submitted_at).filled(:Date)
        end

        rule(:end_on, :start_on) do
          if values[:end_on] && values[:start_on]
            key.failure('End on must be after start on date') unless values[:end_on] > values[:start_on]
          end
        end
      end
    end
  end
end

