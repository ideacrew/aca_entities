# frozen_string_literal: true

require 'dry-types'
require 'date'

module AcaEntities
  module Pdm
    module Entities
      # rubocop:disable Metrics/ModuleLength, Layout/LineLength
      # custom types for curam
      module Types
        send(:include, Dry.Types())
        send(:include, Dry::Logic)

        module Types
          send(:include, Dry.Types())
        end

        ManifestTypes = Types::Coercible::Symbol.enum(
            "RRV_MANIFEST_TYPE",
            "PVC_MANIFEST_TYPE"
          )
  
      end
    end
  end
end