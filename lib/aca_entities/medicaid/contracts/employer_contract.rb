# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for Employer.
      class EmployerContract < Dry::Validation::Contract

        params do
          optional(:id).maybe(:string)
          optional(:category_text).maybe(:string)
          optional(:organization_primary_contact_information).maybe(:hash)
          optional(:organization_augmentation).maybe(:hash)
        end
      end
    end
  end
end
