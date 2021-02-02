# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Questionnaires

    # Extend DryTypes to include IAP
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)


    end
  end
end