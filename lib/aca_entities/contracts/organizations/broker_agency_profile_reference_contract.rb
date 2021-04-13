# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Organizations
      # Schema and validation rules for {AcaEntities::Organizations::BrokerAgencyProfileReference}
      class BrokerAgencyProfileReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :hbx_id required
        # @option opts [Date] :market_kind required
        # @option opts [Boolean] :name required
        # @option opts [Hash] :dba optional
        # @option opts [Hash] :display_name optional
        # @option opts [Hash] :fein required
        # @option opts [Hash] :corporate_npn required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).filled(:string)
          required(:market_kind).filled(
            AcaEntities::Types::BrokerMarketKinds
          )
          required(:name).filled(:string)
          optional(:dba).maybe(:string)
          optional(:display_name).maybe(:string)
          required(:fein).filled(:string)
          optional(:corporate_npn).maybe(:string)
        end
      end
    end
  end
end