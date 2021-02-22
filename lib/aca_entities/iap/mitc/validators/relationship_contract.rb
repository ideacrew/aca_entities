# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        class RelationshipContract < Dry::Validation::Contract

          params do
            required(:other_id).filled(:integer)
            required(:attest_primary_responsibility).filled(Types::YesNoKind)
            required(:relationship_code).filled(Types::RelationshipCodeKind)
          end
        end
      end
    end
  end
end
