# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A stateful instance of a defined eligibility with one or more
    #   {AcaEntities::Eligiblities::EvidenceState}s
    class Determination < Dry::Struct
      attribute :status,
                AcaEntities::Eligibilities::Types::DeterminationStateKind.meta(
                  ommittable: false
                )
      attribute :earliest_due_date, Types::Date.meta(ommittable: false)
      attribute :determined_at, Types::DateTime.meta(ommittable: false)
      attribute :evidence_states, Types::Hash.meta(ommittable: false)

      def initialize(*args)
        super
        update_attributes
      end

      def update_earliest_due_date
        # cycle through evidence_states and set value
      end

      def update_status
        # cycle through evidence_states and set value
      end

      private

      def update_attributes
        # fetch_earliest_due_date
        # update_status
      end
    end
  end
end
