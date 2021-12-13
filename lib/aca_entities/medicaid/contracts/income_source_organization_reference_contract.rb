# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # IncomeSourceOrganizationReference information contract
      class IncomeSourceOrganizationReferenceContract < Dry::Validation::Contract
        params do
          optional(:ref).maybe(:string)
        end
      end
    end
  end
end