# frozen_string_literal: true

require 'dry-types'
require 'date'

module AcaEntities
  module Pdm
    module Entities
      # custom types for curam
      module Types
        send(:include, Dry.Types())
        send(:include, Dry::Logic)

        module Types
          send(:include, Dry.Types())
        end

        ManifestTypes = Types::Coercible::String.enum(
          "rrv_manifest_type",
          "pvc_manifest_type"
        )

      end
    end
  end
end