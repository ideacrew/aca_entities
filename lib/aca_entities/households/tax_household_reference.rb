# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdReference < Dry::Struct
      attribute :max_aptc,                                    AcaEntities::Curreny.meta(omittable: false)
      attribute :monthly_expected_contribution,               AcaEntities::Curreny.meta(omittable: true)
    end
  end
end
