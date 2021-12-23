# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Entity for VerificationHistory
      class VerificationHistoryContract < Dry::Validation::Contract
        params do
          optional(:action).maybe(:string)
          optional(:modifier).maybe(:string)
          optional(:update_reason).maybe(:string)
          optional(:updated_by).maybe(:string)
          optional(:is_satisfied).maybe(:bool)
          optional(:verification_outstanding).maybe(:bool)
          optional(:due_on).maybe(:date)
          optional(:aasm_state).maybe(:string)
        end
      end
    end
  end
end