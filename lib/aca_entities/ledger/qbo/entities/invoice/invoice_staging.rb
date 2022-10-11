# frozen_string_literal: true

module AcaEntities
  module Ledger
    module Qbo
      module Invoice
        class InvoiceStaging < Dry::Struct

          attribute :sub_customer_last_name,      Types::String.optional.meta(omittable: false)
          attribute :sub_customer_external_id,    Types::String.optional.meta(omittable: false)
          attribute :customer_external_id,        Types::String.optional.meta(omittable: false)
          attribute :plan_name,                   Types::String.optional.meta(omittable: false)
          attribute :coverage_type,               Types::String.optional.meta(omittable: false)

          attribute :premium_amount,              Types::Float.optional.meta(omittable: false)
          attribute :benefit_begin_date,          Types::Date.optional.meta(omittable: false)

        end
      end
    end
  end
end