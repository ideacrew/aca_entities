# frozen_string_literal: true

# require 'uri'
require 'cgi'
require 'dry-types'

module AcaEntities
  module BenefitMarkets
    # custom types for benefit sponsors
    module Types
      send(:include, Dry.Types())
      include Dry::Logic

    end
  end
end
