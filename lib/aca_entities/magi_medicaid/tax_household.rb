# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for TaxHousehold.
    class TaxHousehold < Dry::Struct

      attribute :max_aptc, Types::Float.optional.meta(omittable: true)
      attribute :csr, Types::Integer.optional.meta(omittable: true)

      # ['UnDetermined', 'True', 'False']
      attribute :is_insurance_assistance_eligible, Types::IaEligibilityKind.optional.meta(omittable: true)
      attribute :tax_household_members, Types::Array.of(TaxHouseholdMember).optional.meta(omittable: true)
    end
  end
end
