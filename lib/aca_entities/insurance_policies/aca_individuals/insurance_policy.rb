#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      class InsurancePolicy < Dry::Struct
        attribute :id,               Types::String.optional.meta(omittable: true)
        attribute :policy_id,        Types::String.meta(omittable: false)
        attribute :insurer_policy_id,   Types::String.optional.meta(omittable: true)
        attribute :marketplace_segment_id,   Types::String.optional.meta(omittable: true)
        attribute :carrier_policy_id,   Types::String.optional.meta(omittable: true)
        attribute :term_for_np,   Types::Bool.optional.meta(omittable: true)
        attribute :coverage_kind,   Types::String.optional.meta(omittable: true)
        attribute :aasm_state,   Types::String.optional.meta(omittable: true)
        attribute :hbx_enrollment_ids,  Types::Array.of(Types::String).meta(omittable: false)
        attribute :insurance_product,   AcaEntities::InsurancePolicies::InsuranceProduct.meta(omittable: false)
        attribute :insurance_provider,   AcaEntities::InsurancePolicies::InsuranceProvider.meta(omittable: false)
        attribute :enrollments, Types::Array.of(AcaEntities::InsurancePolicies::Enrollment).optional.meta(omittable: true)
        attribute :aptc_csr_tax_households,
                  Types::Array.of(AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold).optional.meta(omittable: true)
        attribute :start_on,         Types::Date.meta(omittable: false)
        attribute :end_on,         Types::Date.optional.meta(omittable: true)
      end
    end
  end
end