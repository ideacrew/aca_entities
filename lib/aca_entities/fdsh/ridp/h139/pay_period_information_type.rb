# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PayPeriodInformationType
        class PayPeriodInformationType < Dry::Struct

          attribute :pay_period_end_date,         Types::Date.meta(omittable: false)
          attribute :income_detail,               Fdsh::Ridp::H139::IncomeType.meta(omittable: false)

        end
      end
    end
  end
end