# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Insurance policy identification information contract
      class InsurancePolicyIdentificationContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
        end
      end
    end
  end
end