# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An Eligibility definition
    class EligibilityItem < Dry::Struct
      include Dry::Monads[:result, :do, :try]

      attribute :id, Types::String.meta(ommittable: true)
      attribute :key, Types::Coercible::String.meta(omittable: false)
      attribute :title, Types::String.optional.meta(omittable: true)
      attribute :description, Types::String.optional.meta(omittable: true)
      attribute :evidence_items, Types::Hash.meta(ommittable: false)
      attribute :tags, Types::Array.of(Types::String).optional.meta(ommittable: true)
      attribute :published_at, Types::DateTime.optional.meta(ommittable: true)

      # Persist the model instance to the backing store
      def create_model
        values = sanitize_attributes

        result = Eligibilities::EligibilityModel.create(values)
        result ? Success(result) : Failure(result)
      end

      # Update the model instance in the backing store
      def update_model(record_id)
        values = sanitize_attributes

        instance = Eligibilities::EligibilityModel.find(record_id)
        result = instance.update_attributes(values)

        result ? Success(result) : Failure(result)
      end

      private

      # Strip any Mondoid-managed attributes from hash
      def sanitize_attributes
        to_h.reject { |k, _v| AcaEntties::Eligibilities::Types::MongoidPrivateKeys.include?(k) }
      end
    end
  end
end
