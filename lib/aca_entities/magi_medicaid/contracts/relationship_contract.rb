# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Contract for Relationship.
      class RelationshipContract < Dry::Validation::Contract

        params do
          required(:kind).filled(:string)
          required(:applicant_id).filled(:string)
          required(:relative_id).filled(:string)
        end
      end
    end
  end
end
