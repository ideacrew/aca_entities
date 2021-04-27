# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Attestation}
      class AttestationContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_incarcerated optional
        # @option opts [Boolean] :is_disabled required
        # @option opts [Boolean] :is_self_attested_long_term_care optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_incarcerated).maybe(:bool)
          required(:is_self_attested_disabled).filled(:bool)
          required(:is_self_attested_blind).filled(:bool)
          optional(:is_self_attested_long_term_care).maybe(:bool)
        end
      end
    end
  end
end
