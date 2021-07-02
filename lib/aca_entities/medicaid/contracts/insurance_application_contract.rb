# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicationContract
      class InsuranceApplicationContract < Dry::Validation::Contract
        params do
          required(:application_metadata).filled(:hash)
          # required(:attestation).filled(:hash)

          # required(:application_creation).filled(:hash), 
          # required(:application_submission).filled(:hash), 
          # required(:application_identifications).filled(:array), 

          required(:insurance_applicants).filled(:array) 
          required(:requesting_financial_assistance).filled(:bool)
          required(:requesting_medicaid).filled(:bool)
          required(:ssf_primary_contact).filled(:hash) 
          optional(:ssf_signer).maybe(:hash) 
          required(:tax_return_access_indicator).filled(:bool)
        end
      end
    end
  end
end
