# frozen_string_literal: true

module AcaEntities
  module Attestations
    # Entity for Attestation
    class AttestationContract < Dry::Validation::Contract

      params do
        required(:attestations).maybe(:hash)
      end
    end
  end
end
