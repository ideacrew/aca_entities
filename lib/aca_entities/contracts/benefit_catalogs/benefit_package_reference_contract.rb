# frozen_string_literal: true

module AcaEntities
  module Contracts
    module BenefitCatalogs
      # Schema and validation rules for {AcaEntities::BenefitCatalogs::BenefitPackageReference}
      class BenefitPackageReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :title required
        # @option opts [String] :elected_premium_credit_strategy required
        # @return [Dry::Monads::Result]
        params do
          required(:title).filled(:string)
          required(:elected_premium_credit_strategy).filled(
            AcaEntities::Types::PremiumCreditStrategyKinds
          )
        end
      end
    end
  end
end