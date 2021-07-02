# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplicant
      class InsuranceApplicant < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
        attribute :age_left_foster_care, Types::Integer.optional.meta(omittable: true)
        attribute :blindness_or_disability_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :lawful_presence_status, InsuranceApplicantLawfulPresenceStatus.optional.meta(omittable: true) 
        attribute :long_term_care_indicator, Types::Bool.optional.meta(omittable: true) 
        attribute :temporarily_lives_outside_application_state_indicator, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
