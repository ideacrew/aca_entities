# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SpouseTaxFiler
      class SpouseTaxFilerContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
        end
      end
    end
  end
end