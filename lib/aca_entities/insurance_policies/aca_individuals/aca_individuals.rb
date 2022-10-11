# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::InsurancePolicies} Domain Model
  module InsurancePolicies
    module AcaIndividuals
      # External dependencies
      require 'aca_entities/insurance_policies/insurance_policies'

      # Contracts
      require_relative 'contracts/contract'

      require_relative 'contracts/tax_household_group_contract'
      require_relative 'contracts/insurance_policy_contract'
      require_relative 'contracts/insurance_agreement_contract'
      require_relative 'contracts/irs_group_contract'

      # Domain Model Entitities
      # require_relative 'member'
    end
  end
end
