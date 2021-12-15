# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # A configuration setting that defines the Evidnece relationship
    # between two objects.  The SubjectRef is the entity object
    # which being described and the EvidenceRef is the entity
    # object that manages a fact about the SubjectRef to be verified.
    #
    # For example, a SubjectRef may be a FamilyMember and an EvidenceRef
    # may be a ConsumerRole that maintains the Verification of Lawful
    # Presence (VLP) for that individual.
    class EvidenceItem < Dry::Struct
      attribute? :id, Types::String.optional.meta(ommittable: true)

      # @!attribute [r] key
      # An unambiguous reference to this EvidenceItem
      # @return [String]
      attribute :key, Types::Coercible::String.meta(omittable: false)

      # @!attribute [r] title
      # A name given to the resource by which the resource is formally known
      # @return [String]
      attribute :title, Types::String.meta(omittable: true)

      # @!attribute [r] description
      # An optional account of the content of this resource
      # @return [String]
      attribute :description, Types::String.optional.meta(ommitable: true)

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
    end
  end
end
