# frozen_string_literal: true

# A Questionnaire's Glossary
module AcaEntities
  module Questionnaires

    # A Topic is a named collection of {Question}s. Topic is intended for internal use only.
    # Use {OrderedTopic} to build a Questionnaire instance
    # @private
    class Topic < Dry::Struct

      # @!attribute [r] key
      # An unambiguous reference to this Topic
      # @return [String]
      attribute :key,         Types::String.meta(omittable: false)

      # @!attribute [r] namespace
      # @return [String]
      attribute :namespace,   Namespace.meta(omittable: false)

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title,       Types::String.meta(omittable: true)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute :description, Types::String.optional.meta(omittable: true)

      # @!attribute [r] questions
      # The set of Questions associated with this Topic
      # @return [Array<Question>]
      attribute :questions,   Types::Array.of(AcaEntities::Questionnaires::Question).optional.meta(omittable: true)

      # @!attribute [r] is_enabled
      # Flag indicating whether the question is active in this Questionnaire
      # instance
      # @return [Boolean]
      attribute :is_enabled,  Types::Bool.meta(omittable: false)

      # @!attribute [r] is_visible
      # Flag indicating whether the question should display in the UI
      # @return [Boolean]
      attribute :is_visible,  Types::Bool.meta(omittable: false)

    end
  end
end
