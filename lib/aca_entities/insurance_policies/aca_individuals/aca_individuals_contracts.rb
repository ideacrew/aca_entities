# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::InsurancePolicies} Domain Model
  module InsurancePolicies
    module AcaIndividualsContracts
      # External dependencies
      require 'aca_entities/insurance_policies/insurance_policies_contracts'

      # Contracts
      require_relative 'contracts/contract'
      require_relative 'contracts/coverage_information_contract'
      require_relative 'contracts/month_of_year_contract'
      require_relative 'contracts/covered_individual_contract'
      require_relative 'contracts/aptc_csr_tax_household_contract'

      require_relative 'contracts/tax_household_group_contract'
      require_relative 'contracts/insurance_policy_contract'
      require_relative 'contracts/insurance_agreement_contract'
      require_relative 'contracts/irs_group_contract'
    end
  end
end
