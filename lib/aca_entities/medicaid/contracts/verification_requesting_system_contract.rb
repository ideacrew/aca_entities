# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for VerificationRequestingSystem
      class VerificationRequestingSystemContract < Dry::Validation::Contract

        params do
          optional(:id).maybe(:string)
          required(:category_code).filled(:string)
          optional(:state_code).maybe(:string)
          optional(:county_name).maybe(:string)
        end

      end
    end
  end
end
