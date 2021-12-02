# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicant.
      class InsuranceApplicantContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
          required(:fixed_address_indicator).filled(:bool)
          optional(:age_left_foster_care).maybe(:integer)
          optional(:blindness_or_disability_indicator).maybe(:bool)
          optional(:coverage_during_previous_six_months_indicator).maybe(:bool)
          optional(:lawful_presence_status).maybe(:hash)
          optional(:long_term_care_indicator).maybe(:bool)
          optional(:recent_medical_bills_indicator).maybe(:bool)
          optional(:eligible_itu_services_indicator).maybe(:bool)
          optional(:received_itu_services_indicator).maybe(:bool)
          optional(:student_indicator).maybe(:bool)
          optional(:medicaid_magi_eligibilities).maybe(:hash)
          optional(:chip_eligibility).maybe(:hash)
          optional(:temporarily_lives_outside_application_state_indicator).maybe(:bool)
          optional(:incarcerations).maybe(:hash)
          optional(:referral_activity).maybe(:hash)
          optional(:foster_care_state).maybe(:string)
          optional(:non_esi_coverage_indicators).maybe(:array)
          optional(:non_esi_policies).maybe(:array)
          optional(:esi_associations).maybe(:array)
          optional(:parent_caretaker_indicator).maybe(:bool)
        end
      end
    end
  end
end
