# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Attestation.
    class AttestationContract < Dry::Validation::Contract

      params do
        optional(:is_incarcerated).maybe(:bool)
        optional(:privacy_policy_agreement_indicator).maybe(:bool)
        required(:attested_not_incarcerated_indicator).filled(:bool)
        optional(:pending_disposition).maybe(:string)
        required(:attested_if_information_changes_indicator).filled(:bool)
        optional(:attested_medicaid_applicant_awareness_indicator).maybe(:bool)
        required(:attested_non_perjury_indicator).filled(:bool)
        optional(:attested_to_cooperate_with_medical_collection_agency).maybe(:bool)
        required(:tax_return_access_indicator).filled(:bool)
        required(:tax_return_access).filled(:bool)
      end
    end
  end
end
