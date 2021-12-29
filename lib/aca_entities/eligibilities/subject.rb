# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An class or object to which an eligiblity is applied
    class Subject < Dry::Struct
      # attribute :gid, Types::Coercible::String.meta(omittable: false)
      attribute :first_name, Types::String.meta(omittable: false)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :dob, Types::Date.meta(omittable: false)
      attribute? :encrypted_ssn, Types::String.meta(omittable: true)
      attribute :hbx_id, Types::String.meta(omittable: false)
      attribute :person_id, Types::String.meta(omittable: false)
      attribute :is_primary, Types::Bool.meta(omittable: false)
      attribute :eligibility_states, Types::Hash.meta(omittable: false)
      attribute :is_ov_eligible,
                AcaEntities::Eligibilities::Types::DeterminationStateKind.meta(
                  ommittable: false
                )
      # def initialize(args)
      #   hash_to_transform = args[:eligibility_states]
      #   args[:eligibility_states] =
      #     hash_to_transform
      #       .keys
      #       .collect { |key| Hash[key, EligibilityState.new(hash_to_transform[key])] }
      #       .reduce(:merge)
      #   super(args)
      # end
    end
  end
end
