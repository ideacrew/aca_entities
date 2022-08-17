# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      # An class or object to which an eligiblity is applied
      class Subject < Dry::Struct
        # attribute :gid, Types::Coercible::String.meta(omittable: false)

        attribute :title, Types::String.meta(omittable: false)
        attribute :description?, Types::String.meta(omittable: true)
        attribute :key, AcaEntities::Eligibilities::Types::SubjectType.meta(ommittable: false)
        attribute :klass, Types::Coercible::String.meta(omittable: false) # GlobalID

        attribute :eligibility_states, Types::Hash.meta(omittable: false)
        attribute :outstanding_verification_status,
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
end
