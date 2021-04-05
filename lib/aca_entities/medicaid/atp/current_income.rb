# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for CurrentIncome.
      class CurrentIncome < Dry::Struct

        attribute :most_recent_hire_date, Types::Date.optional.meta(omittable: true)
        attribute :termination_date, Types::Date.optional.meta(omittable: true)
        attribute :pay_rate, Types::Integer.optional.meta(omittable: true)
        attribute :data_source_payment_frequency_code, Types::String.optional.meta(omittable: true)
      end
    end
  end
end
