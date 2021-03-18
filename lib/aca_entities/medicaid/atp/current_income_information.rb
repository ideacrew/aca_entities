# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for CurrentIncomeInformation
      class CurrentIncomeInformation < Dry::Struct
        attribute :income_type_code, Types::String.optional.meta(omittable: true)
        attribute :income_type_amount, Types::Float.optional.meta(omittable: true)
        attribute :income_frequency_code, Types::String.optional.meta(omittable: true)
        attribute :days_per_week, Types::Integer.optional.meta(omittable: true)
        attribute :hours_per_week, Types::Integer.optional.meta(omittable: true)
        # Indicates whether income from tribal land is current held in trust status
        # and/or from judgment funds or subject to other federal restrictions.
        attribute :is_income_subject_to_federal_restrictions, Types::Bool.optional.meta(omittable: true)
        attribute :employer_name, Types::String.optional.meta(omittable: true)
        attribute :employer_ein, Types::String.optional.meta(omittable: true)
        attribute :type_of_work, Types::String.optional.meta(omittable: true)
        attribute :unemployment_source, Types::String.optional.meta(omittable: true)
        attribute :date_unemployment_ends, Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
