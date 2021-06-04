# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for PregnancyInformation
    class PregnancyInformation < Dry::Struct
      attribute :is_pregnant, Types::Bool.optional.meta(omittable: true)
      attribute :is_enrolled_on_medicaid, Types::Bool.optional.meta(omittable: true)
      attribute :is_postpartum_period, Types::Bool.optional.meta(omittable: true)
      attribute :expected_children_count, Types::Integer.optional.meta(omittable: true)
      attribute :pregnancy_due_on, Types::Date.optional.meta(omittable: true)
      attribute :pregnancy_end_on, Types::Date.optional.meta(omittable: true)
    end
  end
end
