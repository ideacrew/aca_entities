# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicationContract
      class InsuranceApplicationContract < Dry::Validation::Contract
        params do
          # required(:application_metadta).filled(:hash)
          # required(:attestation).filled(:hash)

          required(:insurance_applicants).filled(:array) 
          required(:requesting_financial_assistance).filled(:bool)
          required(:requesting_medicaid).filled(:bool)
          required(:ssf_primary_contact).filled(:hash) 
          required(:tax_return_access_indicator).filled(:bool)
        end
      end
    end
  end
end
