# frozen_string_literal: true

require 'date'

module AcaEntities
  # Types, Entities and Contracts for the {AcaEntities::InsurancePolicies} Domain Model
  module InsurancePolicies

    # Domain Model Entitities
    require_relative 'member'
    require_relative 'insurance_product'
    require_relative 'premium_schedule'
    require_relative 'enrolled_member_premium'
    require_relative 'enrolled_member'
    require_relative 'enrollment'
    require_relative 'insurance_provider'
    require "aca_entities/insurance_policies/aca_individuals/coverage_information"
    require "aca_entities/insurance_policies/aca_individuals/month_of_year"
    require "aca_entities/insurance_policies/aca_individuals/covered_individual"
    require "aca_entities/insurance_policies/aca_individuals/aptc_csr_tax_household"
    require "aca_entities/insurance_policies/aca_individuals/insurance_policy"
    require "aca_entities/insurance_policies/aca_individuals/insurance_agreeement"
  end
end
