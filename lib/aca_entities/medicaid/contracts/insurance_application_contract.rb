# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicationContract
      class InsuranceApplicationContract < Dry::Validation::Contract
        params do
          required(:insurance_applicants).array(:array)
          required(:requesting_financial_assistance).filled(:bool)
          required(:requesting_medicaid).filled(:bool)
          required(:ssf_primary_contact).filled(:hash)
          required(:ssf_signer).filled(:hash)
          required(:tax_return_access).filled(:bool)
          required(:application_creation).filled(:hash)
          required(:application_submission).filled(:hash)
          required(:application_identifications).array(:hash)
          optional(:coverage_renewal_year_quantity).maybe(:integer)

        end

        rule(:coverage_renewal_year_quantity) do
          #
          # key.failure(text: 'coverage_renewal_year_quantity is required if tax_return_access is true') if values[:tax_return_access] == true
        end

      end
    end
  end
end
