# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A stateful instance of a defined eligibility with one or more
    #   {AcaEntities::Eligiblities::EvidenceState}s
    class Determination < Dry::Struct
      include ::AcaEntities::Operations::Mongoid::ModelAdapter

      persistence_model_name 'Eligibilities::Determination'

      attribute :effective_date, Types::Date.meta(omittable: false)
      attribute :subjects, Types::Hash.meta(omittable: false)
      attribute :outstanding_verification_status,
                AcaEntities::Eligibilities::Types::DeterminationStateKind.meta(
                  omittable: false
                )

      attribute :outstanding_verification_earliest_due_date, Types::Date.optional.meta(omittable: false)
      attribute :outstanding_verification_document_status, Types::String.optional.meta(omittable: false)

      attribute :grants, Types::Array.of(AcaEntities::Eligibilities::Grant).optional.meta(omittable: true)

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
