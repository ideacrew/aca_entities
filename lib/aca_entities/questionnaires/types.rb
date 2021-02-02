# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Questionnaires

    # Extend DryTypes to include IAP
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      VersionKind = Types::Coerccable::String.default('0.1.0'.freeze).enum('0.1.0')
    end
  end
end