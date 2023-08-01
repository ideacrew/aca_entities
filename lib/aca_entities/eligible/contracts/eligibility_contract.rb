# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligble::Eligibility
    class EligibilityContract < Contract
      params do
        optional(:_id).filled(Types::Coercible::String)
        required(:key).filled(:symbol)
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:evidences).filled(:array)
        required(:grants).filled(:array)
        required(:state_histories).filled(:array)
        optional(:timestamps).maybe(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end
    end
  end
end
