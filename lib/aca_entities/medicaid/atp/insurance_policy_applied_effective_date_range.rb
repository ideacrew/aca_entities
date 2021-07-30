# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsurancePolicyAppliedEffectiveDateRange
      class InsurancePolicyAppliedEffectiveDateRange < Dry::Struct

        attribute :start_date, StartDate.optional.meta(omittable: true)
        attribute :end_date, EndDate.optional.meta(omittable: true)
      end
    end
  end
end