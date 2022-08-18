# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdGroup < Dry::Struct

      attribute :aasm_state,             Types::String.meta(omittable: false)
      attribute :assistance_year,        Types::Integer.meta(omittable: false)
      attribute :start_on,               Types::Date.meta(omittable: false)
      attribute :end_on,                 Types::Date.meta(omittable: true)
      attribute :source,                 Types::String.meta(omittable: true)
      attribute :application_reference,  AcaEntities::MagiMedicaid::ApplicationReference.optional.meta(omittable: true)
      attribute :tax_households,         Types::Strict::Array.of(AcaEntities::Households::TaxHousehold).optional.meta(omittable: true)

    end
  end
end