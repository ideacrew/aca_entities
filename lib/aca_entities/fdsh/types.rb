# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Fdsh
    # Extend DryTypes to include FDSH
    module Types
      send(:include, Dry.Types)

      # @!attribute [r] FullyRestrictedSSNSimpleType
      # Validates a string is a valid Social Security Number
      # @return [Boolean]
      FullyRestrictedSSNSimpleType =
        Types::String.constrained(
          format: /^(?!000|666)[0-8][0-9]{2}(?!00)[0-9]{2}(?!0000)[0-9]{4}$/
        )
    end
  end
end
