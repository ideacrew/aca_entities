# frozen_string_literal: true

require 'dry-types'
require_relative 'types'
require_relative 'entry'
require_relative 'glossary'
require_relative 'namespace'
require_relative 'question'
require_relative 'topic'
require_relative 'ordered_topic'

module AcaEntities
  module Questionnaires

    # A Questionnaire
    class Questionnaire < Dry::Struct

      # @!attribute [r] version
      # The edition of this Questionnaire domain model
      # @return [String]
      attribute :version,         AcaEntities::Questionnaires::Types::VersionKind.meta(omittable: false)

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
      attribute :description,     Types::String.optional.meta(omittable: true)

      attribute :glossaries,      Types::Array.of(Glossary).optional.meta(omittable: true)

      # @!attribute [r] ordered_topics
      # A tree of {OrderedTopic}s for grouping related Questions into named collections
      # @return [Array<OrderedTopic>]
      attribute :ordered_topics,  Types::Array.of(OrderedTopic).optional.meta(omittable: true)

    end
  end
end
