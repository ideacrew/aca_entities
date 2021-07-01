# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Attestations
    # Extend DryTypes to include Ridp
    module Types
      include Dry.Types
      include Dry::Logic

      RidpStatusKind = Types::Coercible::String.enum('initial', 'in_progress', 'success', 'failure', 'no_response')
    end
  end
end
