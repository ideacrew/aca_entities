# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for Attestation.
    class AttestationContract < Dry::Validation::Contract

      params do
        optional(:is_incarcerated).maybe(:bool)
      end
    end
  end
end
