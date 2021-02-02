# frozen_string_literal: true

require_relative 'glossary'
require_relative 'glossary_entry'
require_relative 'topic'
require_relative 'ordered_topic'
require_relative 'question'

module AcaEntities
  module Entities
    module Shared
      module Questionnaires

        # A Questionnaire
        class Questionnaire < Dry::Struct

          # @!attribute [r] key
          # An unambiguous reference to this Questionnaire
          # @return [String]
          attribute :key,             Types::String.meta(omittable: false)

          # @!attribute [r] title
          # A name given to the resource by which the resource is formally known
          # @return [String]
          attribute :title,           Types::String.meta(omittable: true)

          # @!attribute [r] description
          # An optional account of the content of this resource
          # @return [String]
          attribute :description,     Types::String.optional.meta(ommitable: true)

          attribute :glossaries,      Types::Array.of(Glossary).optional.meta(ommitable: true)

          # @!attribute [r] ordered_topics
          # A tree of {OrderedTopic}s for grouping related Questions into named collections
          # @return [Array<OrderedTopic>]
          attribute :ordered_topics,  Types::Array.of(OrderedTopic).optional.meta(ommitable: true)

        end
      end
    end
  end
end
