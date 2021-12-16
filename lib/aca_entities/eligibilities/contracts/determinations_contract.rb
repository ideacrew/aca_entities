# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Contract for validating {AcaEntities::Eligibilities::Determinations} entity hashes
      class DeterminationsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] :determinations required
        # @return [Dry::Monads::Result::Success] if valid
        # @return [Dry::Monads::Result::Failure] if invalid
        params { required(:determinations).value(:hash) }
      end
    end
  end
end
