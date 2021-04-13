# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonHealth}.
      class PersonHealthContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :is_tobacco_user required
        # @option opts [String] :is_physically_disabled required
        # @return [Dry::Monads::Result]
        params do
          required(:is_tobacco_user).filled(:string)
          optional(:is_physically_disabled).filled(:bool)
        end
      end
    end
  end
end
