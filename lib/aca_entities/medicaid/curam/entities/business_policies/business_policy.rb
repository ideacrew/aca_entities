# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module BusinessPolicies
        # entity for business policy
        class BusinessPolicy < Dry::Struct
          attribute :key,                 Types::String
          attribute :title,               Types::String
          attribute :description,         Types::String.optional.meta(omittable: true)
          attribute :rules,               Types::Array.of(Curam::BusinessPolicies::Rule)
          attribute :severity,            Types::String # Curam::TypesSeverityKind
          attribute :entity_kind,         Types::String
        end
      end
    end
  end
end
