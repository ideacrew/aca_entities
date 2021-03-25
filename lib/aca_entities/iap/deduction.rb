# frozen_string_literal: true

module AcaEntities
  module Iap
    class Deduction < Dry::Struct

      attribute :name,            Types::String.meta(omittable: false)
      attribute :kind,            Types::String.meta(omittable: false)
      attribute :amount,          Types::Decimal.meta(omittable: false)
      attribute :start_on,        Types::Date.meta(omittable: false)
      attribute :end_on,          Types::Date.meta(omittable: false)
      attribute :frequency_kind,  Types::String.meta(omittable: false)
      attribute :submitted_at,    Types::DateTime.meta(omittable: false)

      attribute :workflow,        Iap::Workflow.meta(omittable: false)

    end
  end
end
