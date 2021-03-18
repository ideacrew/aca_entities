# frozen_string_literal: true

module Ehs
  class TaxHouseholds::TaxHouseholdMember < Dry::Struct

    attribute :person_identifiers,        Types::Array.of(Ehs::Identifiers::Id).meta(omittable: false)
    attribute :is_ia_eligible,            Types::Bool.meta(omittable: false)
    attribute :is_medicaid_chip_eligible, Types::Bool.meta(omittable: false)
    attribute :is_without_assistance,     Types::Bool.optional.meta(omittable: true)

    attribute :financial_statements,      Types::Array.of(FinancialStatements::FinancialStatement).meta(omittable: false)
  end
end
