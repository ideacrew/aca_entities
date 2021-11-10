# frozen_string_literal: true

module AcaEntities
  module Contracts
    module People
      # Schema and validation rules for {AcaEntities::People::PersonHealth}.
      class PersonHealthContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :is_tobacco_user required
        # @option opts [String] :is_physically_disabled optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_tobacco_user).maybe(:string)
          optional(:is_physically_disabled).maybe(:bool)
        end

        rule(:is_physically_disabled) do
          key.failure('must be nil or bool') unless [FalseClass, TrueClass, NilClass].member? value.class
        end
      end
    end
  end
end
