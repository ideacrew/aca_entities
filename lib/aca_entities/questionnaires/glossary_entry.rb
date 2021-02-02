# frozen_string_literal: true

module AcaEntities
  module Entities
    module Shared
      module Questionnaire

        # A defined term and definition pair that appears in a Questionnaire's Glossary
        class GlossaryEntry < Dry::Struct

          # @!attribute [r] key
          # An unambiguous reference to a glossary entry instance. The key is used as a token to
          # reference the entry in a questionnaire
          # @return [String]
          attribute :key, Types::String.meta(omittable: false)

          # @!attribute [r] term
          # The display name for a glossary entry.
          # At runtime the term value is substituted for the key token
          # @return [String]
          attribute :term, Types::String.meta(omittable: false)

          # @!attribute [r] definition
          # A statement that represents the concept and essential nature of the named term
          # @return [String]
          attribute :definition, Types::String.meta(omittable: false)

        end
      end
    end
  end
end
