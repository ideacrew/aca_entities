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
        # @return [Dry::Monads::Result]
        params do
          optional(:indian_tribe_member).maybe(:bool)
          optional(:tribal_id).maybe(:string, size?: 9)
        end
      end
    end
  end
end