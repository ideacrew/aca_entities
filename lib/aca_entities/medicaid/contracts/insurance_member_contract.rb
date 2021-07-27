# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Insurance Member contract
      class InsuranceMemberContract < Dry::Validation::Contract
        params do
          optional(:chip_identification).maybe(:hash)
          optional(:medicaid_identification).maybe(:hash)
        end
      end
    end
  end
end