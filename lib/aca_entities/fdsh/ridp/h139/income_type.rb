# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for IncomeType
        class IncomeType < Dry::Struct

          attribute :income_amount,                     Types::Float.optional.meta(omittable: true)
          attribute :income_hours_per_week_measure,     Types::Integer.optional.meta(omittable: true)
          attribute :income_date,                       Types::Date.optional.meta(omittable: true)
          attribute :income_net_payment_amount,         Types::Float.optional.meta(omittable: true)

        end
      end
    end
  end
end