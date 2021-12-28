# frozen_string_literal: true

require 'dry-types'

module AcaEntities
  module Eligibilities
    # Extend DryTypes to include FDSH
    module Types
      send(:include, Dry.Types)

      DeterminationStateKind =
        Types::Coercible::String.enum(
          'eligible',
          'ineligible',
          'verification_outstanding'
        ).freeze

      EvidenceStateKind =
        Types::Coercible::String.enum(
          'pending',
          'requested',
          'outstanding',
          'eligibility_review_required',
          'determined',
          'expired',
          'rejected',
          'errored',
          'review'
        ).freeze

    end
  end
end