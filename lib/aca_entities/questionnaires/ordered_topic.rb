# frozen_string_literal: true

module AcaEntities
  module Entities
    module Shared
      module Questionnaire

        # An OrderedTopic is a {Topic} that includes an integer sequence value indicating its
        # ordinal position relative to other Topics at the same level of hierarchy
        class OrderedTopic < Dry::Struct

          # @!attribute [r] topic
          # The subject Topic
          # @return [Topic]
          attribute :topic, Topic.optional.meta(ommitable: true)

          # @!attribute [r] order
          # The sequence in which this Topic appears relative to other Topics
          # at the same hierarchy level.  Topics will display in ascending order
          # based on the order value.  For example, a Topic with order => 10 will
          # appear before a Topic with order => 20.
          # @return [Integer]
          attribute :order, Types::Integer.optional.meta(ommitable: true)

          # @!attribute [r] ordered_topics
          # The recursive set of Question groups that are children to this one
          # @return [Array<OrderedTopic>]
          attribure :ordered_topics, Array.of(OrderedTopic).optional.meta(ommitable: true)
        end

      end
    end
  end
end
