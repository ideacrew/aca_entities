# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Questionnaires

    # Extend DryTypes to include IAP
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      VersionKind = Types::Coercible::String.default('0.1.0').enum('0.1.0')
      DataTypeKind = Types::Coercible::String.enum
    end
  end
end