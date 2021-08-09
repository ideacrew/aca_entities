# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # CHIP identification information contract
      class ChipIdentificationContract < Dry::Validation::Contract
        params do
          required(:identification_id).filled(:string)
        end
      end
    end
  end
end