# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module People
        # Contract for PersonRelationship
        class PersonRelationshipContract < Curam::ApplicationContract
          params do
            required(:subject_individual_id).filled(:string)
            required(:object_individual_id).filled(:string)
            required(:relationship_uri).filled(:string)
          end

          rule(:relationship_uri) do
            key.failure(text: 'invalid relationship_uri') if key? && value && !Types::FamilyRelationshipKind.include?(value)
          end
        end
      end
    end
  end
end
