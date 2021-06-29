# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::MemberPremiumContract}
      class MemberPremiumContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Array] :member_identifier required
        # @option opts [Array] :monthly_premium required
        # @return [Dry::Monads::Result]
        params do
          required(:member_identifier).filled(:string)
          required(:monthly_premium).filled(Types::Money)
        end
      end
    end
  end
end
