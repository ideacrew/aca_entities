# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Medicaid identification information contract
      class MedicaidIdentificationContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
        end
      end
    end
  end
end