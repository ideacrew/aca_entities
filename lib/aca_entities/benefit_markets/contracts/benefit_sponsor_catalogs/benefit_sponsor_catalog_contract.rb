# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module BenefitSponsorCatalogs
      # Contract for BenefitSponsorCatalog
      class BenefitSponsorCatalogContract < BenefitMarkets::ApplicationContract

        params do
          required(:effective_date).filled(:date)
          required(:effective_period).value(type?: Range)
          required(:open_enrollment_period).value(type?: Range)
          required(:probation_period_kinds).array(:symbol)
          # optional(:benefit_application).maybe(:hash)
          required(:product_packages).value(:array)
          # required(:service_area_ids).array(Types::Bson)
        end

        # rule(:benefit_application) do
        #   if key? && value
        #     result = BenefitApplicationContract.new.call(value)
        #     key.failure(text: "invalid benefit application", error: result.errors.to_h) if result&.failure?
        #   end
        # end

        # rule(:product_packages).each do
        #   if key? && value
        #     result = BenefitMarkets::Products::ProductPackageContract.new.call(value)
        #     key.failure(text: "invalid product package", error: result.errors.to_h) if result&.failure?
        #   end
        # end
      end
    end
  end
end
