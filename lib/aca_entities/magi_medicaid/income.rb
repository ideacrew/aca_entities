# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Income.
    class Income < Dry::Struct
      attribute :title, Types::String.optional.meta(omittable: true)
      attribute :kind, Types::IncomeKind.optional.meta(omittable: true)
      attribute :wage_type, Types::String.optional.meta(omittable: true)
      attribute :hours_per_week, Types::Integer.optional.meta(omittable: true)
      attribute :amount, Types::Float.optional.meta(omittable: true)
      attribute :amount_tax_exempt, Types::Float.optional.meta(omittable: true)
      attribute :frequency_kind, Types::IncomeFrequency.optional.meta(omittable: true)
      attribute :start_on, Types::Date.optional.meta(omittable: true)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
      attribute :is_projected, Types::Bool.optional.meta(omittable: true)

      # tax_form is only defined in IAP Income Mongoid::Document and not used anywhere in IAP engine.
      attribute :tax_form, Types::String.optional.meta(omittable: true)
      attribute :employer, Employer.optional.meta(omittable: true)
      attribute :has_property_usage_rights, Types::Bool.optional.meta(omittable: true)
      attribute :submitted_at, Types::DateTime.optional.meta(omittable: true)
    end
  end
end
