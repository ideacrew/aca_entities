# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for InsuranceApplicationContract
    class InsuranceApplicationContract < Dry::Validation::Contract
      params do
        required(:application_metadta).filled(:hash)
        required(:attestation).filled(:hash)
      end
    end
  end
end
