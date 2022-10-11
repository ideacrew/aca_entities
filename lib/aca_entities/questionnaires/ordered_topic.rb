# frozen_string_literal: true

module AcaEntities
  module Questionnaires

    # An OrderedTopic is a {Topic} that includes an integer sequence value indicating its
    # ordinal position relative to other Topics at the same level of hierarchy
    class OrderedTopic < Dry::Struct

      # @!attribute [r] topic
      # The subject Topic
      # @return [Topic]
      attribute :topic, AcaEntities::Questionnaires::Topic.optional.meta(omittable: true)

      # @!attribute [r] order
      # The sequence in which this Topic appears relative to other Topics
      # at the same hierarchy level.  Topics will display in ascending order
      # based on the order value.  For example, a Topic with order => 10 will
      # appear before a Topic with order => 20.
      # @return [Integer]
      attribute :order, Types::Integer.optional.meta(omittable: true)

      # @!attribute [r] ordered_topics
      # The recursive set of Question groups that are children to this one
      # @return [Array<OrderedTopic>]
      attribute :ordered_topics,
                Types::Array.of(AcaEntities::Questionnaires::OrderedTopic).optional.meta(omittable: true)
    end
  end
end
