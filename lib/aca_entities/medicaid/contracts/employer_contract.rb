# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Employer.
      class EmployerContract < Dry::Validation::Contract

        params do
          required(:id).filled(:string)
          optional(:category_text).maybe(:string)
          optional(:organization_primary_contact_information).maybe(:hash)
        end
      end
    end
  end
end
