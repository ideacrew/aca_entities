# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module TaxHouseholds
        # entity for TaxHousehold
        class TaxHousehold < Dry::Struct

          attribute :maximum_aptc,          Types::Decimal.meta(omittable: false)
          attribute :csr_percent,           Types::Decimal.meta(omittable: false)
          attribute :tax_household_members, Types::Array.of(TaxHouseholdMember).meta(omittable: false)
        end
      end
    end
  end
end
