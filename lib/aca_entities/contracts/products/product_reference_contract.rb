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
        # @option opts [String] :csr_variant_id optional
        # @option opts [String] :is_csr optional
        # @option opts [String] :family_deductible optional
        # @option opts [String] :individual_deductible optional
        # @option opts [Hash] :issuer_profile required
        # @return [Dry::Monads::Result]
        params do
          required(:hios_id).filled(:string)
          required(:name).filled(:string)
          required(:active_year).filled(:integer)
          required(:is_dental_only).filled(:bool)
          required(:metal_level).filled(:string)
          required(:benefit_market_kind).filled(:string)  # TODO: types
          required(:product_kind).filled(:string) # TODO: types
          optional(:ehb_percent).maybe(:string)
          optional(:csr_variant_id).maybe(:string)
          optional(:is_csr).maybe(:bool)
          optional(:family_deductible).maybe(:string)
          optional(:individual_deductible).maybe(:string)
          required(:issuer_profile_reference).hash(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)
        end
      end
    end
  end
end