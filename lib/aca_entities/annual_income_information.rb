# frozen_string_literal: true

module AcaEntities
  class AnnualIncomeInformation < Dry::Struct

    attribute :attested_annual_income_next_year, Types::Float.optional.meta(omittable: true)
    attribute :attested_annual_income_this_year, Types::Float.optional.meta(omittable: true)
    attribute :unknown_income,                   Types::String.optional.meta(omittable: true) # TBD
    attribute :variable_income,                  Types::String.optional.meta(omittable: true)
    attribute :estimated_annual_income_for_aptc, Types::Float.optional.meta(omittable: true)
  end
end
