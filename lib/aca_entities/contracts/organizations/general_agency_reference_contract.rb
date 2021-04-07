# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Organizations
      # Schema and validation rules for {AcaEntities::Organizations::GeneralAgencyReference}
      class GeneralAgencyReferenceContract < Dry::Validation::Contract
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
            AcaEntities::Types::GeneralAgencyMarketKinds
          )
          required(:name).filled(:string)
          optional(:dba).filled(:string)
          optional(:display_name).filled(:string)
          required(:fein).filled(:string)
          required(:corporate_npn).filled(:string)
        end
      end
    end
  end
end
