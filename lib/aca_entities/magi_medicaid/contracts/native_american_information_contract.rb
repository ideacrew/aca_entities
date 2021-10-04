# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::NativeAmericanInformation}
      class NativeAmericanInformationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :indian_tribe_member optional
        # @option opts [String] :tribal_id optional
        # @option opts [String] :tribal_name optional
        # @option opts [String] :tribal_state optional
        # @return [Dry::Monads::Result]
        params do
          optional(:indian_tribe_member).maybe(:bool)
          optional(:tribal_id).maybe(:string)
          optional(:tribal_name).maybe(:string)
          optional(:tribal_state).maybe(Types::UsStateAbbreviationKind)
          optional(:health_service_eligible).maybe(:bool)
          optional(:health_service_through_referral).maybe(:bool)
        end
      end
    end
  end
end
