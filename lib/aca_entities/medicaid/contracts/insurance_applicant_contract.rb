# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicant.
      class InsuranceApplicantContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
          optional(:esi_eligible_indicator).maybe(:bool)
          optional(:age_left_foster_care).maybe(:integer)
          optional(:foster_care_state).maybe(:string)
          optional(:had_medicaid_during_foster_care_indicator).maybe(:bool)
          optional(:blindness_or_disability_indicator).maybe(:bool)
          optional(:lawful_presence_status).maybe(:hash)
          optional(:long_term_care_indicator).maybe(:bool)
          optional(:chip_eligibility).maybe(:hash)
          optional(:temporarily_lives_outside_application_state_indicator).maybe(:bool)
          optional(:foster_care_indicator).maybe(:bool)
        end
      end
    end
  end
end
