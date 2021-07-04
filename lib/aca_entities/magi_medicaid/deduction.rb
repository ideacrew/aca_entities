# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Deduction.
    class Deduction < Dry::Struct

      # title
      attribute :name,            Types::String.optional.meta(omittable: true)
      attribute :kind,            Types::DeductionKind.optional.meta(omittable: true)
      attribute :amount,          Types::Money.optional.meta(omittable: true)
      attribute :start_on,        Types::Date.optional.meta(omittable: true)
      attribute :end_on,          Types::Date.optional.meta(omittable: true)
      attribute :frequency_kind,  Types::DeductionFrequency.optional.meta(omittable: true)
      attribute :submitted_at,    Types::DateTime.optional.meta(omittable: true)

      # attribute :workflow,        Iap::Workflow.meta(omittable: false)
    end
  end
end
