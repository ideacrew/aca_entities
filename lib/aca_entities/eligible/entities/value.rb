# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligible
    # A value can be cost sharing credit, employer contribution percentage
    # or osse premium credit
    class Value < Dry::Struct

      # @!attribute [r] _id
      # An id reference to this Value
      # @return [String]
      attribute? :_id, Types::Coercible::String.optional.meta(omittable: true)

      # @!attribute [r] title
      # Value title
      # @return [String]
      attribute :title, Types::String.meta(omittable: false)

      # @!attribute [r] description
      # Value description
      # @return [String]
      attribute :description?, Types::String.optional.meta(omittable: true)

      # @!attribute [r] key
      # Type of grant, for example cost sharing, employer contribution
      # or osse premium credit
      # @return [Symbol]
      attribute :key, Types::Symbol.meta(omittable: false)

      # @!attribute [r] item
      # A item can be contribution percentage, cost sharing credit
      # or osse premium credit
      # @return [String]
      attribute :item, Types::Any.meta(omittable: true)
    end
  end
end
