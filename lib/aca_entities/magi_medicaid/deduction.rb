# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Deduction.
    class Deduction < Dry::Struct

      # field :title
      # field :kind
      # field :amount
      # field :start_on
      # field :end_on
      # field :frequency_kind
      # field :submitted_at
      # field :workflow

      # title
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
