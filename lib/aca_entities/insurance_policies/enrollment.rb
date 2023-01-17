#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    class Enrollment < Dry::Struct
      attribute :subscriber,         AcaEntities::InsurancePolicies::EnrolledMember.optional.meta(omittable: false)
      attribute :spouse,           AcaEntities::InsurancePolicies::EnrolledMember.optional.meta(omittable: true)
      attribute :survivor,         AcaEntities::InsurancePolicies::EnrolledMember.optional.meta(omittable: true)
      attribute :dependents,      Types::Strict::Array.of(AcaEntities::InsurancePolicies::EnrolledMember).optional.meta(omittable: true)
      attribute :tax_households,  Types::Strict::Array.of(AcaEntities::Households::TaxHousehold).optional.meta(omittable: true)
      attribute :total_premium_amount, AcaEntities::Currency.meta(omittable: false)
      attribute :total_premium_adjustment_amount, AcaEntities::Currency.meta(omittable: false)
      attribute :total_responsible_premium_amount, AcaEntities::Currency.optional.meta(omittable: true)
      attribute :start_on,         Types::Date.optional.meta(omittable: true)
      attribute :end_on,         Types::Date.optional.meta(omittable: true)
    end
  end
end