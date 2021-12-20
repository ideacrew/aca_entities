# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Contract for validating { EligibilityState } entity hashes
      class EligibilityStatesContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] :eligibility_states required
        # @return [Dry::Monads::Result::Success] if valid
        # @return [Dry::Monads::Result::Failure] if invalid
        params { required(:eligibility_states).value(:hash) }
      end
    end
  end
end
