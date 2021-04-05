# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp TaxHouseholdComposition
      class TaxHouseholdComposition < Dry::Struct

        attribute :tax_household_size_change_expected, Types::Bool.optional.meta(omittable: true)
        attribute :tax_filer_indicator, Types::String.optional.meta(omittable: true) # TBD
        attribute :dependent_indicator, Types::String.optional.meta(omittable: true) # TBD
        attribute :claims_dependent_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :married_filing_jointly_code, Types::String.optional.meta(omittable: true)
        attribute :member_of_applicant_tax_household, Types::String.optional.meta(omittable: true) # TBD
        attribute :custodial_claiming_tax_filer, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
