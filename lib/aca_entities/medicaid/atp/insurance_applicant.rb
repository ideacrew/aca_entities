# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplicant
      class InsuranceApplicant < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
        attribute :esi_eligible_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :age_left_foster_care, Types::Integer.optional.meta(omittable: true)
        attribute :foster_care_state, Types::String.optional.meta(omittable: true)
        attribute :had_medicaid_during_foster_care_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :blindness_or_disability_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :coverage_during_previous_six_months_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :lawful_presence_status, InsuranceApplicantLawfulPresenceStatus.optional.meta(omittable: true)
        attribute :long_term_care_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :medicaid_magi_eligibilities, Types::Array.of(MedicaidMagiEligibility).optional.meta(omittable: true)
        attribute :chip_eligibilities, Types::Array.of(ChipEligibility).optional.meta(omittable: true)
        attribute :temporarily_lives_outside_application_state_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :foster_care_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :fixed_address_indicator, Types::Bool.meta(omittable: false)
        attribute :incarcerations, Types::Array.of(Incarceration).optional.meta(omittable: true)
        attribute :referral_activity, ReferralActivity.optional.meta(omittable: true)
        attribute :non_esi_coverage_indicators, Types::Array.of(Types::Bool).optional.meta(omittable: true)
        attribute :non_esi_policies, Types::Array.of(InsuranceApplicantNonEsiPolicy).optional.meta(omittable: true)
        attribute :esi_associations, Types::Array.of(InsuranceApplicantEsiassociation).optional.meta(omittable: true)
      end
    end
  end
end
