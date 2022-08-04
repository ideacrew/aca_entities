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
          'outstanding',
          'pending',
          'not_enrolled'
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
          'review',
          'attested',
          'verified',
          'non_verified',
          'denied',
          'errored',
          'closed',
          'corrected',
          'unverified',
          'negative_response_received'
        ).freeze

      SubjectType =
        Types::Coercible::String.enum(
          'FamilyMemberSubject',
          'OrganizationSubject'
        ).freeze
    end
  end
end
