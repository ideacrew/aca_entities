# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets HealthProduct
    class HealthProduct < BenefitMarkets::Product

      attribute :hios_id,                         Types::Strict::String.meta(omittable: false)
      attribute :hios_base_id,                    Types::Strict::String.meta(omittable: false)
      attribute :csr_variant_id,                  Types::String.optional.meta(omittable: true)
      attribute :health_plan_kind,                Types::Strict::Symbol.meta(omittable: true)
      attribute :metal_level_kind,                Types::Strict::Symbol.meta(omittable: false)
      attribute :ehb,                             Types::Strict::Float.meta(omittable: false)
      attribute :is_standard_plan,                Types::Strict::Bool.meta(omittable: false)
      attribute :rx_formulary_url,                Types::String.optional.meta(omittable: true)
      attribute :hsa_eligibility,                 Types::Strict::Bool.meta(omittable: false)
      attribute :provider_directory_url,          Types::String.optional.meta(omittable: true)
      attribute :network_information,             Types::String.optional.meta(omittable: true)
    end
  end
end