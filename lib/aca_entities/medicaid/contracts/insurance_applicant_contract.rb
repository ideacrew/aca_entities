# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicant.
      class InsuranceApplicantContract < Dry::Validation::Contract

        params do
          required(:role_reference).filled(:hash)
          optional(:age_left_foster_care).maybe(:integer)
          optional(:blindness_or_disability_indicator).maybe(:bool)
          optional(:lawful_presence_status).maybe(:hash)
          optional(:long_term_care_indicator).maybe(:bool)
          optional(:chip_eligibility).maybe(:hash)
          optional(:temporarily_lives_outside_application_state_indicator).maybe(:bool)
          optional(:incarcerations).maybe(:hash)
        end
      end
    end
  end
end
