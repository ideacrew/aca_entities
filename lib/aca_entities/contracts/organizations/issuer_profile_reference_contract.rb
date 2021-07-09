# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Organizations
      # Schema and validation rules for {AcaEntities::Organizations::GeneralAgencyReference}
      class IssuerProfileReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Date] :hbx_id required
        # @option opts [Date] :fein optional
        # @option opts [Date] :hbx_carrier_id optional
        # @option opts [String] :phone optional
        # @option opts [Boolean] :name required
        # @option opts [Hash] :abbrev required
        # @return [Dry::Monads::Result]
        params do
          required(:hbx_id).value(:str?)
          optional(:fein).filled(:string)
          optional(:hbx_carrier_id).filled(:string)
          optional(:phone).filled(:string)
          required(:name).filled(:string)
          required(:abbrev).filled(:string)
        end
      end
    end
  end
end
