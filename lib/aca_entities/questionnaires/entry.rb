# frozen_string_literal: true

module AcaEntities
  module Questionnaires

    # A defined term and definition pair that appears in a Questionnaire's Glossary
    class Entry < Dry::Struct

      # @!attribute [r] key
      # An unambiguous reference to a term. The key is used as a token to
      # reference where an term should appear in a rendered {Questionnaire}
      # @return [String]
      attribute :key, Types::String.meta(omittable: false)

      # @!attribute [r] term
      # The human-readable word or phrase to define
      # At runtime this value is substituted inline where a matching token is encountered
      # @return [String]
      attribute :term, Types::String.meta(omittable: false)

      # @!attribute [r] definition
      # A statement that represents the concept and essential nature of the term
      # @return [String]
      attribute :definition, Types::String.meta(omittable: false)

    end
  end
end
