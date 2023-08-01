# frozen_string_literal: true

module AcaEntities
  module Eligible
    # contract for Eligible::Value
    class ValueContract < Dry::Validation::Contract
      params do
        optional(:_id).maybe(:string)
        required(:title).filled(:string)
        optional(:description).maybe(:string)
        required(:key).filled(:symbol)
        optional(:item).filled(:any)
      end
    end
  end
end
