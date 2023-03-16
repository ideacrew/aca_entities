# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Products
      # Schema and validation rules for {AcaEntities::Products::FamilyRatedPremiums}
      class FamilyRatedPremiumsContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :exchange_provided_code optional
        # @option opts [Float] :primary_enrollee optional
        # @option opts [Float] :primary_enrollee_one_dependent optional
        # @option opts [Float] :primary_enrollee_two_dependents optional
        # @option opts [Float] :primary_enrollee_many_dependent optional
        # @return [Dry::Monads::Result]
        params do
          optional(:exchange_provided_code).maybe(Types::String)
          optional(:primary_enrollee).maybe(:float)
          optional(:primary_enrollee_one_dependent).maybe(:float)
          optional(:primary_enrollee_two_dependents).maybe(:float)
          optional(:primary_enrollee_many_dependent).maybe(:float)
        end
      end
    end
  end
end
