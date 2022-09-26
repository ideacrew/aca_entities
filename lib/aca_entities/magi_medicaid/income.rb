# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Income.
    class Income < Dry::Struct
      attribute :title, Types::String.optional.meta(omittable: true)
      attribute :kind, Types::IncomeKind.meta(omittable: false)
      attribute :wage_type, Types::String.optional.meta(omittable: true)
      attribute :hours_per_week, Types::Integer.optional.meta(omittable: true)
      attribute :amount, Types::Money.meta(omittable: false)
      attribute :amount_tax_exempt, Types::Money.optional.meta(omittable: true)
      attribute :frequency_kind, Types::IncomeFrequency.meta(omittable: false)
      attribute :start_on, Types::Date.meta(omittable: false)
      attribute :end_on, Types::Date.optional.meta(omittable: true)
      attribute :is_projected, Types::Bool.optional.meta(omittable: true)
      attribute :employer, Employer.optional.meta(omittable: true)
      attribute :has_property_usage_rights, Types::Bool.optional.meta(omittable: true)
      attribute :ssi_type, Types::String.optional.meta(omittable: true)
      attribute :submitted_at, Types::DateTime.optional.meta(omittable: true)

      def earned?
        Types::EarnedIncomeKinds.include?(kind)
      end
    end
  end
end
