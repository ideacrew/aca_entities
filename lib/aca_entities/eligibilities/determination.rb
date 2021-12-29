# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A stateful instance of a defined eligibility with one or more
    #   {AcaEntities::Eligiblities::EvidenceState}s
    class Determination < Dry::Struct
      include ::AcaEntities::Operations::Mongoid::ModelAdapter

      persistence_model_name 'Eligibilities::Determination'

      attribute :effective_date, Types::Date
      attribute :subjects, Types::Hash.meta(ommittable: false)
      attribute :is_ov_eligible, Types::DeterminationStateKind.meta(ommittable: false)

      # def initialize(args)
      #   hash_to_transform = args[:subjects]
      #   args[:subjects] =
      #     hash_to_transform
      #       .keys
      #       .collect { |key| Hash[key, Subject.new(hash_to_transform[key])] }
      #       .reduce(:merge)
      #   super(args)
      # end
    end
  end
end
