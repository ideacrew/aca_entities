# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for TaxDependent
      class TaxDependentContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
          optional(:claimed_by_custodial_parent_indicator).filled(:bool)
          optional(:tin_identification).filled(:hash)
        end
      end
    end
  end
end