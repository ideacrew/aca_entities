# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::Evidence
    class EvidenceContract < Contract
      params do
        optional(:_id).filled(Types::Coercible::String)
        required(:key).filled(:symbol)
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:is_satisfied).filled(:bool)
        required(:state_histories).filled(:array)
        required(:subject_ref).value(type?: URI)
        optional(:evidence_ref).value(type?: URI)
        optional(:timestamps).filled(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end
    end
  end
end
