# frozen_string_literal: true

module AcaEntities
  module Contracts
    class EmailContract < Dry::Validation::Contract

      params do
        required(:kind).filled(:string)
        required(:address).filled(:string)
      end
    end
  end
end
