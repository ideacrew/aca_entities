# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for TaxReturn
      class TaxReturn < Dry::Struct
        attribute :total_exemptions_quantity,               Types::Integer.optional.meta(omittable: true)
        attribute :status_code,                             Types::TaxReturnFilingStatusCode.optional.meta(omittable: true)
        attribute :tax_return_year,                         Types::Integer.optional.meta(omittable: true)
        attribute :tax_household,                           TaxHousehold.meta(omittable: false)
        attribute :tax_return_includes_dependent_indicator, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
