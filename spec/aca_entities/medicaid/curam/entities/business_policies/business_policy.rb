# frozen_string_literal: true

module Ehs
  module BusinessPolicies
    class BusinessPolicy < Dry::Struct
      attribute :key,                 Types::String
      attribute :title,               Types::String
      attribute :description,         Types::String.optional.meta(omittable: true)
      attribute :rules,               Types::Array.of(Ehs::BusinessPolicies::Rule)
      attribute :severity,            Types::String #Ehs::Types::SeverityKind
      attribute :entity_kind,         Types::String
    end
  end
end
