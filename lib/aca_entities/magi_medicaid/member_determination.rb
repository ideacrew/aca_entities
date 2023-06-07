# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 MagiMedicaid Entity for MemberDetermination.
    class MemberDetermination < Dry::Struct

      # @!attribute [r] category
      # The kind of determination.
      # @return [AcaEntities::MagiMedicaid::Types::MemberDeterminationKind]
      attribute :kind, ::AcaEntities::MagiMedicaid::Types::MemberDeterminationKind

      # @!attribute [r] is_eligible
      # Whether or not the {Applicant} is eligible for the kind of determination.
      # @return [Boolean]
      attribute :is_eligible, Types::Bool

      # @!attribute [r] determination_reasons
      # The reasons the {Applicant} qualifies for the determination.
      # @return [Array]
      attribute :determination_reasons, Types::Array.of(Types::Symbol)

      # @!attribute [r] eligibility_overrides
      # The eligibility overrides for the determination.
      # @return [Array]
      attribute :eligibility_overrides, Types::Array.of(EligibilityOverride)
    end
  end
end
