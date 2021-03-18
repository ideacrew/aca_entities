# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp PayPeriodInformation
      class PayPeriodInformation < Dry::Struct
        attribute :end_date, Types::Date.optional.meta(omittable: true)
        attribute :hours_worked_in_pay_period, Types::Integer.optional.meta(omittable: true)
        attribute :data_source_income_type_amount, Types::Float.optional.meta(omittable: true)
      end
    end
  end
end
