# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # SSF Signer information contract
      class SsfSignerContract < Dry::Validation::Contract
        params do
          required(:role_reference).filled(:hash)
          optional(:signature).maybe(:hash)
          optional(:ssf_signer_authorized_representative_association).maybe(:hash)
          optional(:ssf_attestation).maybe(:hash)
        end
      end
    end
  end
end