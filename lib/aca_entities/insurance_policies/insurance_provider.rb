#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class InsuranceProvider < Dry::Struct
      attribute :title,         Types::String.meta(omittable: false)
      attribute :hios_id, Types::String.meta(omittable: false)
      attribute :fein, Types::String.meta(omittable: false)
      attribute :insurance_products, Types::Strict::Array.of(AcaEntities::InsurancePolicies::InsuranceProduct).optional.meta(omittable: true)
    end
  end
end