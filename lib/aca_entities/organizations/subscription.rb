# frozen_string_literal: true

module AcaEntities
  module Organizations
    class Subscription < Dry::Struct
      attribute :feature_key,     Types::RequiredSymbol
      attribute :id,              Types::String.optional
      attribute :validator_id,    Types::String.optional
      attribute :subscribed_at,   Types::String.optional
      attribute :unsubscribed_at, Types::String.optional
      attribute :settings,        Types::Array.of(ResourceRegistry::Entities::Setting).meta(omittable: true)
    end
  end
end
