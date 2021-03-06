# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module Products
      # Contract for product
      class ProductContract < Dry::Validation::Contract

        params do
          required(:product_reference).filled(BenefitMarkets::Products::ProductReferenceContract.params)
          required(:benefit_market_kind).filled(:symbol)
          required(:application_period).filled(type?: Range)
          optional(:hbx_id).maybe(:string)
          required(:title).filled(:string)
          optional(:description).maybe(:string)
          required(:issuer_profile_reference).filled(AcaEntities::Contracts::Organizations::IssuerProfileReferenceContract.params)
          required(:product_package_kinds).array(:symbol)
          required(:kind).filled(:symbol)
          required(:premium_ages).filled(type?: Range)
          optional(:provider_directory_url).maybe(:string)
          required(:is_reference_plan_eligible).filled(:bool)
          optional(:deductible).maybe(:string)
          optional(:family_deductible).maybe(:string)
          optional(:issuer_assigned_id).maybe(:string)
          required(:service_area).filled(BenefitMarkets::Locations::ServiceAreaContract.params)
          optional(:network_information).maybe(:string)
          optional(:nationwide).maybe(:bool)
          optional(:dc_in_network).maybe(:bool)
          optional(:renewal_product_reference).maybe(BenefitMarkets::Products::ProductReferenceContract.params)
          optional(:sbc_document).maybe(BenefitMarkets::DocumentContract.params)
          required(:premium_tables).array(BenefitMarkets::Products::PremiumTableContract.params)
        end

        rule(:sbc_document) do
          if key && value
            result = DocumentContract.new.call(value)
            key.failure(text: "invalid document", error: result.errors.to_h) if result&.failure?
          end
        end

        rule(:premium_tables).each do
          if key && value
            result = PremiumTableContract.new.call(value)
            key.failure(text: "invalid premium table", error: result.errors.to_h) if result&.failure?
          end
        end
      end
    end
  end
end