# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for VerificationHistory
    class VerificationHistoryContract < Dry::Validation::Contract
      params do
        optional(:action).maybe(:string)
        optional(:modifier).maybe(:string)
        optional(:update_reason).maybe(:string)
      end
    end
  end
end