# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Attestations
    # Extend DryTypes to include Ridp
    module Types
      include Dry.Types
      include Dry::Logic

      RidpStatusKind = Types::Coercible::String.enum('in progress', 'completed')
    end
  end
end
