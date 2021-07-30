# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # IncomeSourceOrganizationReference information contract
      class IncomeSourceOrganizationReferenceContract < Dry::Validation::Contract
        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end