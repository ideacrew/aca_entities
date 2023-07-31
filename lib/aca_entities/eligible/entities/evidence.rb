# frozen_string_literal: true

module AcaEntities
  module Eligible
    # entity class for Evidence
    class Evidence < Dry::Struct

      INELIGIBLE_STATUSES = %i[initial denied].freeze
      ELIGIBLE_STATUSES = %i[approved].freeze
      EVENTS = %i[move_to_initial move_to_approved move_to_denied].freeze

      STATE_TRANSITION_MAP = {
        initial: [:initial],
        approved: [:initial, :denied],
        denied: [:initial, :approved]
      }.freeze

      # @!attribute [r] id
      # An id reference to this Evidence
      # @return [Symbol]
      attribute? :id, Types::String.optional.meta(omittable: true)

      # @!attribute [r] key
      # An unambiguous reference to this Evidence
      # @return [Symbol]
      attribute :key, Types::Symbol.meta(omittable: false) # currently stored as :osse_subsidy

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title, Types::String.meta(omittable: false)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute? :description, Types::String.optional.meta(omittable: true)

      # @!attribute [r] is_satisfied
      # Boolean value that responsents whether an evidence is satisfied or not
      # @return [Boolean]
      attribute :is_satisfied, Types::Bool.optional.meta(omittable: false)

      # @!attribute [r] subject_ref
      # A class or object described by the {evidence_ref}
      # @return [String]
      attribute :subject_ref,
                Types::Coercible::String.optional.meta(omittable: false)

      # @!attribute [r] evidence_ref
      # A class or object that maintains the state for a fact
      # about the {subject_ref}
      # @return [String]
      attribute :evidence_ref,
                Types::Coercible::String.optional.meta(omittable: false)

      # @!attribute [r] state_histories
      # Collection of resource historical states and associated eligibility
      # @return [Array]
      attribute :state_histories,
                Types::Array.of(AcaEntities::Eligible::StateHistory).meta(
                  omittable: false
                )

      # @!attribute [r] timestamp
      # Timestamp of the resource ie. submitted, created or modified time of the resource
      # @return [Timestamp]
      attribute :timestamp,
                AcaEntities::TimeStamp.optional.meta(omittable: true)

      def satisfied?
        # state_histories.last.approved?
      end

      # def latest_is_eligible
      #   latest_history&.is_eligible
      # end

      # def latest_effective_on
      #   latest_history&.effective_on
      # end

      # def latest_state
      #   latest_history&.to_state
      # end

      # def latest_history
      #   site_histories.max_by(&:transition_at)
      # end
    end
  end
end
