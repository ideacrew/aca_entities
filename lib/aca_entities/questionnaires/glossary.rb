# frozen_string_literal: true

module AcaEntities
  module Questionnaires

    # A Glossary is a dictionary that contains a list of terms and their definitions
    class Glossary < Dry::Struct

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title,             Types::String.meta(omittable: true)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute :description,       Types::String.optional.meta(omittable: true)

      # @!attribute [r] entries
      # A collection of term/definition pairs
      # @return [Array<GlossaryEntry>]
      attribute :entries,  Types::Array.of(Entry).optional.meta(omittable: true)
    end

  end
end
