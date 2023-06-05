# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 MagiMedicaid Entity for EligibilityOverride.
    class EligibilityOverride < Dry::Struct

      # @!attribute [r] override_rule
      # The override rule that may be applied to the determination.
      # @return [AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule]
      attribute :override_rule, ::AcaEntities::MagiMedicaid::Types::EligibilityOverrideRule

      # @!attribute [r] override_applied
      # Whether or not the override rule was applied to the determination.
      # @return [Boolean]
      attribute :override_applied, Types::Bool.optional.meta(omittable: true)

    end
  end
end