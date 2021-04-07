# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Employer}
      class EmployerContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :employer_name required
        # @option opts [String] :employer_id required
        # @return [Dry::Monads::Result]
        params do
          required(:employer_name).filled(:string)
          required(:employer_id).filled(:string)
        end

        rule(:employer_id) do
          key.failure(text: 'should be of length 9 and allows numbers only') if key? && value && !value.match?(/^[0-9]{9}$/)
        end
      end
    end
  end
end
