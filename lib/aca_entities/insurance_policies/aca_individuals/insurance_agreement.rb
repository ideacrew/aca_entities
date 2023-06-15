#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class InsuranceAgreement < Dry::Struct
        attribute :id,               Types::String.optional.meta(omittable: true)
        attribute :plan_year,         Types::Integer.optional.meta(omittable: false)
        attribute :contract_holder,   AcaEntities::InsurancePolicies::Member.optional.meta(omittable: true)
        attribute :insurance_provider, AcaEntities::InsurancePolicies::InsuranceProvider.optional.meta(omittable: true)
        attribute :insurance_policies,
                  Types::Strict::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::InsurancePolicy).optional.meta(omittable: true)
        attribute :start_on,         Types::Date.optional.meta(omittable: true)
        attribute :end_on,         Types::Date.optional.meta(omittable: true)
        attribute :effectuated_on,         Types::Date.optional.meta(omittable: true)
      end
    end
  end
end