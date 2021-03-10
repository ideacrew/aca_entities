# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for BasisForOutcome.
    class BasisForOutcomeContract < Dry::Validation::Contract

      params do
        optional(:is_blind_or_disabled).maybe(:bool)
        optional(:attested_long_term_care).maybe(:bool)
      end
    end
  end
end
