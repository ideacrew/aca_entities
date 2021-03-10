# frozen_string_literal: true

module AcaEntities
  # Entity for Relationship.
  class Relationship < Dry::Struct

    attribute :relationship_to_tax_filer_code, Types::String.optional.meta(omittable: true)
    attribute :attested_child_of_caretaker_code, Types::String.optional.meta(omittable: true)
    attribute :absent_parent_code, Types::String.optional.meta(omittable: true)
    attribute :attested_caretaker, Types::Bool.optional.meta(omittable: true)
    attribute :lives_with_minor_age_dependent, Types::Bool.optional.meta(omittable: true)
    attribute :lives_with_other_parent_not_claimer, Types::Bool.optional.meta(omittable: true)
    attribute :person_for_work_quarters, Types::Bool.optional.meta(omittable: true)
    attribute :parent_caretaker_to_child_relationship_code, Types::String.optional.meta(omittable: true)
    attribute :parent1_hours_worked_per_week, Types::Integer.optional.meta(omittable: true)
    attribute :parent2_hours_worked_per_week, Types::Integer.optional.meta(omittable: true)
  end
end
