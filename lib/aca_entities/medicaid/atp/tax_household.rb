# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp TaxHousehold
      class TaxHousehold < Dry::Struct
        attribute :household_incomes, Types::Array.of(HouseholdIncome).optional.meta(omittable: true)
        attribute :household_size_change_expected_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :primary_tax_filer, PrimaryTaxFiler.optional.meta(omittable: true)
        attribute :spouse_tax_filer, SpouseTaxFiler.optional.meta(omittable: true)
        attribute :tax_dependents, Types::Array.of(TaxDependent).optional.meta(omittable: true)
        attribute :household_member_references, Types::Array.of(HouseholdMemberReference).optional.meta(omittable: true)
        attribute :household_size_quantity, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end