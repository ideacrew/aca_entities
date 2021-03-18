# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for Verification
      class Verification < Dry::Struct
        attribute :verification_header,         VerificationHeader.optional.meta(omittable: true)
        attribute :ssa_information,             SsaInformation.optional.meta(omittable: true)
        attribute :dhs_save,                    DhsSave.optional.meta(omittable: true)
        attribute :tax_household_annual_income, TaxHouseholdAnnualIncome.optional.meta(omittable: true)
        attribute :basis_for_outcome,           BasisForOutcome.optional.meta(omittable: true)
        attribute :address,                     Address.optional.meta(omittable: true)
      end
    end
  end
end
