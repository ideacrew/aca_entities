# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    # Entity for benefirmarkets DentalProduct
    class DentalProduct < BenefitMarkets::Product

      attribute :hios_id,                       Types::Strict::String.meta(omittable: false)
      attribute :hios_base_id,                  Types::Strict::String.meta(omittable: false)
      attribute :csr_variant_id,                Types::String.optional.meta(omittable: true)
      attribute :dental_level,                  Types::Strict::Symbol.meta(omittable: false)
      attribute :dental_plan_kind,              Types::Strict::Symbol.meta(omittable: false)
      attribute :metal_level_kind,              Types::Strict::Symbol.meta(omittable: false)
      attribute :ehb,                           Types::Strict::Float.meta(omittable: false)
      attribute :is_standard_plan,              Types::Strict::Bool.meta(omittable: false)
      attribute :hsa_eligibility,               Types::Strict::Bool.meta(omittable: false)
    end
  end
end
