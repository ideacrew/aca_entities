# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Determinations
      # Schema and validation rules for {AcaEntities::Determinations::EligibilityDeterminationReferenceContract}
      class EligibilityDeterminationReferenceContract < Dry::Validation::Contract
        params do
          required(:hbx_assigned_id).filled(:string)
          required(:effective_starting_on).filled(:date)
        end
      end
    end
  end
end