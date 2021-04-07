# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHousehold < Dry::Struct

      # This map to tax_household#hbx_assigned_id
      attribute :hbx_id,                         Types::String.optional.meta(omittable: false)
      attribute :allocated_aptc,                  AcaEntities::Curreny.meta(omittable: false)
      attribute :is_eligibility_determined,       Types::Bool.optional.meta(omittable: false)
      attribute :start_date,                      Types::Date.meta(omittable: false)
      attribute :end_date,                        Types::Date.meta(omittable: false)
      # attribute :tax_household_size,              AcaEntities::Households::TaxHouseholdSize.meta(omittable: true)
      # Is this used for curram account transfer, check if it is depricated.
      # attribute :total_incomes_by_year,           Types::Decimal.optional.meta(omittable: true)
      attribute :tax_household_members,           Types::Strict::Array.of(AcaEntities::Households::TaxHouseholdMember).meta(omittable: false)
      attribute :eligibility_determinations,      Types::Strict::Array.of(AcaEntities::Determinations::EligibilityDetermination).optional.meta(omittable: true)
    end
  end
end

