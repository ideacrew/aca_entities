# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::Value
    class ValueContract < Dry::Validation::Contract
      params do
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:key).filled(:string)
      end
    end
  end
end
