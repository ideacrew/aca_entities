# frozen_string_literal: true

require_relative 'insurance_policy_contract'

module AcaEntities
  module Medicaid
    module Contracts
      # Insurance applicant esi association contract
      class InsuranceApplicantEsiAssociationContract < Dry::Validation::Contract
        params do
          optional(:eligible_indicator).filled(:bool)
          optional(:enrolled_indicator).filled(:bool)
          optional(:eligibility_unknown_indicator).filled(:bool)
        end
      end
    end
  end
end