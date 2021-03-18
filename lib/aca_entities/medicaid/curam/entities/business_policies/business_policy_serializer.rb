# frozen_string_literal: true

module Ehs
  module BusinessPolicies
    class BusinessPolicySerializer < ActiveJob::Serializers::ObjectSerializer
      # Checks if an argument should be serialized by this serializer.
      def serialize?(argument)
        argument.is_a? ::Ehs::BusinessPolicies::BusinessPolicy
      end
     
      # Converts an object to a simpler representative using supported object types.
      # The recommended representative is a Hash with a specific key. Keys can be of basic types only.
      # You should call `super` to add the custom serializer type to the hash.
      def serialize(business_policy)
        super(
          key: business_policy.key,
          title: business_policy.title,
          description: business_policy.description,
          entity_kind: business_policy.entity_kind,
          rules: business_policy.rules,
          severity: business_policy.severity
        )
      end
     
      # Converts serialized value into a proper object.
      def deserialize(hash)
        ::Ehs::BusinessPolicies::BusinessPolicy.new({
          key: hash[:key],
          title: hash[:title],
          description: hash[:description],
          entity_kind: hash[:entity_kind],
          rules: hash[:rules],
          severity: hash[:severity]
        })
      end
    end
  end
end