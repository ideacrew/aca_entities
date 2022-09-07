# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHousehold < Dry::Struct

      # This map to tax_household#hbx_assigned_id
      attribute :hbx_id,                          Types::String.optional.meta(omittable: true)
      attribute :allocated_aptc,                  AcaEntities::Currency.optional.meta(omittable: true)
      attribute :is_eligibility_determined,       Types::Bool.optional.meta(omittable: true)
      attribute :start_date,                      Types::Date.optional.meta(omittable: true)
      attribute :end_date,                        Types::Date.optional.meta(omittable: true)
      # attribute :tax_household_size,              AcaEntities::Households::TaxHouseholdSize.meta(omittable: true)
      # Is this used for curram account transfer, check if it is depricated.
      # attribute :total_incomes_by_year,           Types::Decimal.optional.meta(omittable: true)
      attribute :tax_household_members,           Types::Strict::Array.of(AcaEntities::Households::TaxHouseholdMember).meta(omittable: false)
      attribute :eligibility_determinations,
                Types::Strict::Array.of(AcaEntities::Determinations::EligibilityDetermination).optional.meta(omittable: true)

      # Yearly Expected Contribution
      attribute :yearly_expected_contribution, ::AcaEntities::Types::Money.optional.meta(omittable: true)

      attribute :eligibility_determination_hbx_id, Types::String.optional.meta(omittable: true)
      attribute :max_aptc,                      AcaEntities::Currency.optional.meta(omittable: true)
      attribute :aptc_accumulator,              AcaEntities::AptcCsrEligibilitiesEnrollments::AptcAccumulator.optional.meta(omittable: true)
      attribute :contribution_accumulator,     AcaEntities::AptcCsrEligibilitiesEnrollments::ContributionAccumulator.optional.meta(omittable: true)
    end
  end
end

