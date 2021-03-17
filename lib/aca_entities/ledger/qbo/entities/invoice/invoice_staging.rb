# frozen_string_literal: true

module Qbo::Invoice
  class InvoiceStaging < Dry::Struct

    attribute :sub_customer_last_name,      Types::String.optional.meta(ommittable: false)
    attribute :sub_customer_external_id,    Types::String.optional.meta(ommittable: false)
    attribute :customer_external_id,        Types::String.optional.meta(ommittable: false)
    attribute :plan_name,                   Types::String.optional.meta(ommittable: false)
    attribute :coverage_type,               Types::String.optional.meta(ommittable: false)

    attribute :premium_amount,              Types::Float.optional.meta(ommittable: false)
    attribute :benefit_begin_date,          Types::Date.optional.meta(ommittable: false)

  end
end