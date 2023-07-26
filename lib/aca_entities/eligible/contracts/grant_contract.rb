# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::Grant
    class GrantContract < Contract
      params do
        optional(:id).maybe(:string)
        required(:key).filled(:symbol)
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:value).filled(AcaEntities::Eligible::ValueContract.params)
        required(:state_histories).filled(:array)
        optional(:timestamps).filled(
          AcaEntities::Contracts::TimeStampContract.params
        )
      end
    end
  end
end
