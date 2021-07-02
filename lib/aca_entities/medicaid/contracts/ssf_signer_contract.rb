# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for SsfSigner
      class SsfSignerContract < Dry::Validation::Contract

        params do
          optional(:ssf_attestation).maybe(:hash)
        end
      end
    end
  end
end
