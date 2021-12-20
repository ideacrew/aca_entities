# frozen_string_literal: true

require 'date'

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # require 'aca_entities/operations/mongoid/model_adapter'

    require_relative 'types'

    # require_relative 'contracts/types_contract'
    require_relative 'contracts/evidence_item_contract'
    require_relative 'contracts/evidence_state_contract'
    require_relative 'contracts/evidence_states_contract'
    require_relative 'contracts/eligibility_item_contract'
    require_relative 'contracts/eligibility_state_contract'
    require_relative 'contracts/eligibility_states_contract'
    require_relative 'contracts/determination_contract'
    require_relative 'contracts/subject_contract'
    require_relative 'contracts/subjects_contract'

    # require_relative 'contracts/eligibility_snapshot_contract'

    require_relative 'evidence_item'
    require_relative 'evidence_state'
    require_relative 'evidence_states'
    require_relative 'eligibility_item'
    require_relative 'eligibility_states'
    require_relative 'determination'
    require_relative 'subject'
    require_relative 'subjects'

    # A granted permission or benefit
    class EligibilityState < Dry::Struct
      attribute? :id, Types::Coercible::String.meta(omittable: true)
      attribute :eligibility_item_key,
                Types::Coercible::String.meta(omittable: false)
      attribute :is_eligible, Types::Bool.meta(omittable: false)
      attribute :earliest_due_date, Types::Date.meta(omittable: false)
      attribute :determined_at, Types::DateTime.meta(omittable: false)
      attribute :evidence_states, Types::Hash.meta(omittable: false)

      # def initialize(*args)
      #   super(args)
      # end

      # after_initialize :set_attributes

      def fetch_status
        evidence_states.all?(&:is_satisfied)
      end

      def fetch_earliest_due_date
        evidence_states.min_by(&:due_on)
      end

      private

      def set_attributes
        @earliest_due_date = fetch_earliest_due_date
        @is_eligible = fetch_status
        @determined_at = DateTime.now
      end
    end
  end
end
