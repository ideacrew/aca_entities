# frozen_string_literal: true

module AcaEntities
  # Entity for CoverageSpecificInformation.
  class CoverageSpecificInformation < Dry::Struct

    attribute :coverage_type_code, Types::String.optional.meta(omittable: true)
    attribute :total_premium, Types::Float.optional.meta(omittable: true)
    attribute :aptc, Types::Float.optional.meta(omittable: true)
    attribute :net_premium, Types::Float.optional.meta(omittable: true)
    attribute :qhp_issuer_id, Types::String.optional.meta(omittable: true)
    attribute :qhp_id, Types::String.optional.meta(omittable: true)
    attribute :metal_level_code, Types::String.optional.meta(omittable: true)
    attribute :issuer_name, Types::String.optional.meta(omittable: true)
    attribute :plan_name, Types::String.optional.meta(omittable: true)
  end
end
