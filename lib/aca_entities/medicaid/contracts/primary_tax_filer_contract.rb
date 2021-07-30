# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PrimaryTaxFiler
      class PrimaryTaxFilerContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
        end
      end
    end
  end
end