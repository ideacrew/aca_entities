# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    class PricingUnit < Dry::Struct
      transform_keys(&:to_sym)

      # attribute :_id,                 Types::Bson
      attribute :name,                Types::Strict::String
      attribute :display_name,        Types::Strict::String
      attribute :order,               Types::Strict::Integer

    end
  end
end