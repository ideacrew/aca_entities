# frozen_string_literal: true

module AcaEntities
  module Eligible
    # entity class for Grant
    class Grant < Dry::Struct
      # @!attribute [r] id
      # An id reference to this Grant
      # @return [Symbol]
      attribute? :id, Types::String.optional.meta(omittable: true)

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

      # @!attribute [r] state_histories
      # Collection of resource historical states and associated eligibility
      # @return [Array]
      attribute :state_histories,
                Types::Array.of(AcaEntities::Eligible::StateHistory).meta(
                  omittable: false
                )

      # @!attribute [r] timestamp
      # Timestamp of the resource ie. submitted, created or modified time of the resource
      # @return [Timestamp]
      attribute :timestamp,
                AcaEntities::TimeStamp.optional.meta(omittable: true)

      # def latest_is_eligible
      #   latest_history&.is_eligible
      # end

      # def latest_effective_on
      #   latest_history&.effective_on
      # end

      # def latest_state
      #   latest_history&.to_state
      # end

      # def latest_history
      #   site_histories.max_by(&:transition_at)
      # end
    end
  end
end
