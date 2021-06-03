# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets BenefitSponsorCatalog
    class BenefitSponsorCatalog < Dry::Struct

      attribute :effective_date,          Types::Strict::Date
      attribute :effective_period,        Types::Range
      attribute :open_enrollment_period,  Types::Range
      attribute :probation_period_kinds,  Types::Strict::Array
      # attribute :benefit_application_id,  Types::String.optional
      attribute :product_packages,        Types::Array.of(BenefitMarkets::ProductPackage)
      # attribute :service_area_ids,        Types::Strict::Array

    end
  end
end