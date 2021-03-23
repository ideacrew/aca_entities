# frozen_string_literal: true

module AcaEntities
  module Iap
    class Income < Dry::Struct
      attribute :start_on,                Types::Date.optional.meta(omittable: true)
      attribute :end_on,                  Types::Date.optional.meta(omittable: true)
      attribute :kind,                    Iap::Types::IncomeKind.optional.meta(omittable: true)
      attribute :amount,                  Types::Decimal.optional.meta(omittable: true)

    end
  end
end
