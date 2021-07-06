# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for IncomeSourceOrganizationReference
      class IncomeSourceOrganizationContract < Dry::Validation::Contract

        params do
          optional(:ref).maybe(:string)
        end
      end
    end
  end
end
