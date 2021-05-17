# frozen_string_literal: true

module AcaEntities
  module BenefitMarkets
    module PricingModels
      # Contract for MemberRelationship
      class MemberRelationshipContract < Dry::Validation::Contract

        params do
          required(:relationship_name).filled(:symbol)
          required(:relationship_kinds).array(:string)
          optional(:age_threshold).maybe(:integer)
          optional(:age_comparison).maybe(:symbol)
          optional(:disability_qualifier).maybe(:bool)
        end
      end
    end
  end
end