# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Products
      # Schema and validation rules for {AcaEntities::Products::ProductReference}
      class ProductReferenceContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :hios_id required
        # @option opts [String] :name required
        # @option opts [Integer] :active_year required
        # @option opts [Bool] :is_dental_only required
        # @option opts [String] :metal_level required
        # @option opts [String] :coverage_type required
        # @option opts [String] :ehb_percent required
        # @option opts [Hash] :issuer_profile required
        # @return [Dry::Monads::Result]
        params do
          required(:hios_id).filled(:string)
          required(:name).filled(:string)
          required(:active_year).filled(:integer)
          required(:is_dental_only).filled(:bool)
          required(:metal_level).filled(:string)
          required(:coverage_type).filled(:string)
          required(:ehb_percent).filled(:string)
          required(:issuer_profile).filled(:hash)
        end

        rule(:issuer_profile) do
          if key? && value
            if value.is_a?(Hash)
              result = AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.new.call(value)
              key.failure(text: "invalid issuer profile", error: result.errors.to_h) if result&.failure?
            else
              key.failure(text: "invalid issuer profile. Expected a hash.")
            end
          end
        end
      end
    end
  end
end