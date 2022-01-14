# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Contract for validating {AcaEntities::Eligibilities::Subjects} entity hashes
      class EvidenceStatesContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] :evidence_states required
        # @return [Dry::Monads::Result::Success] if valid
        # @return [Dry::Monads::Result::Failure] if invalid
        params { required(:evidence_states).value(:hash) }
      end
    end
  end
end
