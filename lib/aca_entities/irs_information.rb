# frozen_string_literal: true

module AcaEntities
  class IrsInformation < Dry::Struct

    attribute :total_exemptions, Types::Integer.optional.meta(omittable: true)
    attribute :filing_status, Types::String.optional.meta(omittable: true)
    attribute :filing_year, Types::Integer.optional.meta(omittable: true)
    attribute :magi_amount, Types::Float.optional.meta(omittable: true)
    attribute :tin_identification, Types::Integer.optional.meta(omittable: true)
    attribute :taxable_social_security_benefits, Types::Float.optional.meta(omittable: true)
    attribute :agi_amount, Types::Float.optional.meta(omittable: true)
  end
end
