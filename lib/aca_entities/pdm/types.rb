# frozen_string_literal: true

require 'dry-types'
require 'date'

module AcaEntities
  module Pdm
    # custom types for PDM
    module Types
      send(:include, Dry.Types())
      send(:include, Dry::Logic)

      ManifestTypes = Types::Coercible::String.enum(
        "rrv_manifest_type",
        "pvc_manifest_type"
      )

      RequestCommandTypes = Types::Coercible::String.enum(
        "medicare",
        "death_certificate"
      )

    end
  end
end