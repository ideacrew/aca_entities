# frozen_string_literal: true

module AcaEntities
  module Evidences
    # Entity for VerificationStatus
    class VerificationStatusContract <  Dry::Validation::Contract
      params do
        optional(:status).maybe(:string)
        optional(:title).maybe(:string)
        optional(:description).maybe(:string)
        optional(:due_on).maybe(:date)
        optional(:updated_by).maybe(:string)
        optional(:assigned_to).maybe(:string)
        optiinal(:documents).array(AcaEntities::Contracts::Documents::DocumentContract.params)
      end
    end
  end
end
