# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdReference < Dry::Struct
      attribute :hbx_id,                            Types::String.meta(omittable: false)
      attribute :max_aptc,                          AcaEntities::Currency.meta(omittable: false)
      attribute :monthly_expected_contribution,     AcaEntities::Currency.meta(omittable: false)
    end
  end
end
