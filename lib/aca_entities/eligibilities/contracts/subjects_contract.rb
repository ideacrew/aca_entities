# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Contract for validating {AcaEntities::Eligibilities::Subjects} entity hashes
      class SubjectsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] :subjects required
        # @return [Dry::Monads::Result::Success] if valid
        # @return [Dry::Monads::Result::Failure] if invalid
        params { required(:subjects).value(:hash) }
      end
    end
  end
end
