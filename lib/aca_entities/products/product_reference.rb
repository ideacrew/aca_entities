# frozen_string_literal: true

module AcaEntities
  module Products
    class ProductReference < Dry::Struct
      attribute :hios_id, Types::Strict::String.meta(omittable: false)
      attribute :name, Types::Strict::String.meta(omittable: false)
      attribute :active_year, Types::Integer.meta(omittable: false)
      attribute :is_dental_only, Types::Strict::Bool.meta(omittable: false)
      attribute :metal_level, Types::Strict::String.meta(omittable: false)
      attribute :benefit_market_kind, Types::Strict::String.meta(omittable: false)
      attribute :product_kind, Types::Strict::String.meta(omittable: false)
      attribute :ehb_percent, Types::Strict::String.optional.meta(omittable: true)
      attribute :csr_variant_id, Types::Strict::String.optional.meta(omittable: true)
      attribute :is_csr, Types::Strict::Bool.optional.meta(omittable: true)
      attribute :family_deductible, Types::Strict::String.optional.meta(omittable: true)
      attribute :individual_deductible, Types::Strict::String.optional.meta(omittable: true)
      attribute :issuer_profile_reference, AcaEntities::Organizations::IssuerProfileReference.meta(omittable: false)
    end
  end
end
