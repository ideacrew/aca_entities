# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Cv3 Entity for BenefitMarkets::Product
    class Product < Dry::Struct
      transform_keys(&:to_sym)

      # attribute :_id,                         Types::Bson
      attribute :benefit_market_kind,         Types::Strict::Symbol
      attribute :application_period,          Types::Range
      attribute :hbx_id,                      Types::String.optional
      attribute :title,                       Types::Strict::String
      attribute :description,                 Types::String.optional
      # attribute :issuer_profile_id,           Types::Bson
      attribute :product_package_kinds,       Types::Strict::Array
      attribute :kind,                        Types::Strict::Symbol
      attribute :premium_ages,                Types::Range
      attribute :provider_directory_url,      Types::String.optional
      attribute :is_reference_plan_eligible,  Types::Strict::Bool
      attribute :deductible,                  Types::String.optional
      attribute :family_deductible,           Types::String.optional
      attribute :issuer_assigned_id,          Types::String.optional
      # attribute :service_area_id,             Types::Bson
      attribute :network_information,         Types::String.optional
      attribute :nationwide,                  Types::Bool.optional
      attribute :dc_in_network,               Types::Bool.optional
      # attribute :renewal_product_id,          Types::Bson.optional

      attribute :sbc_document,                BenefitMarkets::Document.optional.meta(omittable: true)
      attribute :premium_tables,              Types::Array.of(BenefitMarkets::PremiumTable)

      def member_premium(effective_date, age)
        p_table = premium_tables.detect do |table|
          table.effective_period.cover?(effective_date)
        end
        p_table&.member_premium(age)
      end
    end
  end
end