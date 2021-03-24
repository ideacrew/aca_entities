# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Income.
    class Income < Dry::Struct
      # field :title
      # field :kind
      # field :wage_type
      # field :hours_per_week
      # field :amount
      # field :amount_tax_exempt
      # field :frequency_kind
      # field :start_on
      # field :end_on
      # field :is_projected
      # field :tax_form
      # field :employer_name
      # field :employer_id
      # field :has_property_usage_rights
      # field :submitted_at
      # field :workflow

      attribute :start_on,                Types::Date.optional.meta(omittable: true)
      attribute :end_on,                  Types::Date.optional.meta(omittable: true)
      attribute :kind,                    Iap::Types::IncomeKind.optional.meta(omittable: true)
      attribute :amount,                  Types::Decimal.optional.meta(omittable: true)

    end
  end
end
