# frozen_string_literal: true

module AcaEntities
  module Eligible
    # entity class for Grant
    class Grant < Dry::Struct
      # @!attribute [r] _id
      # An id reference to this Grant
      # @return [String]
      attribute? :_id, Types::String.optional.meta(omittable: true)

      # @!attribute [r] key
      # An unambiguous reference to this Grant
      # @return [Symbol]
      attribute :key, Types::Symbol.meta(omittable: false)

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title, Types::String.meta(omittable: false)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute :description?, Types::String.optional.meta(omittable: true)

      # @!attribute [r] value
      # Grant value
      # @return [AcaEntities::Eligible::Value]
      attribute :value, AcaEntities::Eligible::Value

      # @!attribute [r] timestamp
      # Timestamp of the resource ie. submitted, created or modified time of the resource
      # @return [Timestamp]
      attribute :timestamps,
                AcaEntities::TimeStamp.optional.meta(omittable: true)
    end
  end
end
