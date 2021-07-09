# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # SSF Attestation information contract
      class SsfAttestationContract < Dry::Validation::Contract
        params do
          required(:non_perjury_indicator).filled(:bool)
          required(:not_incarcerated_indicators).filled(:array)
          required(:information_changes_indicator).filled(:bool)
          optional(:collections_agreement_indicator).maybe(:bool)
          optional(:medicaid_obligations_indicator).maybe(:bool)
          optional(:privacy_agreement_indicator).maybe(:bool)
          optional(:pending_charges_indicator).maybe(:bool)
          optional(:application_terms_indicator).maybe(:bool)
        end
      end
    end
  end
end
