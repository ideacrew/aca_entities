#  frozen_string_literal: true

module AcaEntities
  module InsurancePolicies
    module AcaIndividuals
      # Insurance Policy Contract
      class InsurancePolicy < Dry::Struct
        attribute :id, Types::String.optional.meta(omittable: true)
        attribute :policy_id, Types::String.meta(omittable: false)
        attribute :insurer_policy_id, Types::String.optional.meta(omittable: true)
        attribute :marketplace_segment_id, Types::String.optional.meta(omittable: true)
        attribute :carrier_policy_id, Types::String.optional.meta(omittable: true)
        attribute :term_for_np, Types::Bool.optional.meta(omittable: true)
        attribute :coverage_kind, Types::String.optional.meta(omittable: true)
        attribute :aasm_state, Types::String.optional.meta(omittable: true)
        attribute :insurance_product, AcaEntities::InsurancePolicies::InsuranceProduct.meta(omittable: false)
        attribute :insurance_provider, AcaEntities::InsurancePolicies::InsuranceProvider.optional.meta(omittable: true)
        attribute :enrollments,
                  Types::Array.of(AcaEntities::InsurancePolicies::Enrollment).optional.meta(omittable: true)
        attribute :aptc_csr_tax_households,
                  Types::Array
                    .of(AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold)
                    .optional
                    .meta(omittable: true)
        attribute :start_on, Types::Date.meta(omittable: false)
        attribute :end_on, Types::Date.optional.meta(omittable: true)

        # Return if this member instance is the same as the other
        def <=>(other)
          policy_comp =
            [start_on, end_on, aasm_state, carrier_policy_id, term_for_np] <=> [
              other.start_on,
              other.end_on,
              other.aasm_state,
              other.carrier_policy_id,
              other.term_for_np
            ]

          { diff: policy_comp }
        end

        # primary_tax_filer_hbx_id is a unique identifier to find AcaEntities::InsurancePolicies::AcaIndividuals::AptcCsrTaxHousehold
        def find_tax_household_by(primary_tax_filer_hbx_id)
          return if policy_id.blank?

          aptc_csr_tax_households.detect do |tax_household|
            tax_household.primary_tax_filer_hbx_id == primary_tax_filer_hbx_id
          end
        end
      end
    end
  end
end
