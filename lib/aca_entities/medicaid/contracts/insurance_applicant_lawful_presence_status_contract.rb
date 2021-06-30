# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for InsuranceApplicantLawfulPresenceStatusContract
      class InsuranceApplicantLawfulPresenceStatusContract < Dry::Validation::Contract

        params do
          optional(:arrived_before_1996_indicator).maybe(:bool)
          optional(:lawful_presence_status_eligibility).maybe(:hash)
        end
      end
    end
  end
end
