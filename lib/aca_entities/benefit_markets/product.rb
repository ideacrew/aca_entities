# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Cv3 Entity for BenefitMarkets::Product
    class Product < Dry::Struct

      attribute :product_reference,           AcaEntities::BenefitMarkets::ProductReference.meta(omittable: false)
      attribute :benefit_market_kind,         Types::Strict::Symbol.meta(omittable: false)
      attribute :application_period,          Types::Range.meta(omittable: false)
      attribute :hbx_id,                      Types::String.optional.meta(omittable: true)
      attribute :title,                       Types::Strict::String.meta(omittable: false)
      attribute :description,                 Types::String.optional.meta(omittable: true)
      attribute :issuer_profile_reference,    AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)

      attribute :product_package_kinds,       Types::Strict::Array.meta(omittable: false)
      attribute :kind,                        Types::Strict::Symbol.meta(omittable: false)
      attribute :premium_ages,                Types::Range.meta(omittable: false)
      attribute :provider_directory_url,      Types::String.optional.meta(omittable: true)
      attribute :is_reference_plan_eligible,  Types::Strict::Bool.meta(omittable: false)
      attribute :deductible,                  Types::String.optional.meta(omittable: true)
      attribute :family_deductible,           Types::String.optional.meta(omittable: false)
      attribute :issuer_assigned_id,          Types::String.optional.meta(omittable: false)
      attribute :service_area,                AcaEntities::BenefitMarkets::ServiceArea.meta(omittable: false)

      attribute :network_information,         Types::String.optional.meta(omittable: true)
      attribute :nationwide,                  Types::Bool.optional.meta(omittable: true)
      attribute :dc_in_network,               Types::Bool.optional.meta(omittable: false)
      attribute :renewal_product_reference,   AcaEntities::BenefitMarkets::ProductReference.optional.meta(omittable: false)

      attribute :sbc_document,                BenefitMarkets::Document.optional.meta(omittable: true)
      attribute :premium_tables,              Types::Array.of(BenefitMarkets::PremiumTable).meta(omittable: false)

      def member_premium(effective_date, age)
        p_table = premium_tables.detect do |table|
          table.effective_period.cover?(effective_date)
        end
        p_table&.member_premium(age)
      end
    end
  end
end