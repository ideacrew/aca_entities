# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SsfPrimaryContact
      class SsfPrimaryContactContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
          required(:contact_preference).filled(:string)
        end
      end
    end
  end
end