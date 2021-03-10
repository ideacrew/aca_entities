# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Relationship.
    class RelationshipContract < Dry::Validation::Contract

      params do
        optional(:relationship_to_tax_filer_code).maybe(Types::RelationshipToTaxFilerCode)
        optional(:attested_child_of_caretaker_code).maybe(Types::AttestedChildOfCaretakerCode)
        optional(:absent_parent_code).maybe(Types::AbsentParentCode)
        optional(:attested_caretaker).maybe(:bool)
        optional(:lives_with_minor_age_dependent).maybe(:bool)
        optional(:lives_with_other_parent_not_claimer).maybe(:bool)
        optional(:person_for_work_quarters).maybe(:bool)
        optional(:parent_caretaker_to_child_relationship_code).maybe(Types::ParentCaretakerToChildRelationshipCode)
        optional(:parent1_hours_worked_per_week).maybe(:integer)
        optional(:parent2_hours_worked_per_week).maybe(:integer)
      end

      rule(:relationship_to_tax_filer_code) do
        if key?
          # required if applicant is a tax dependent
        end
      end
    end
  end
end
