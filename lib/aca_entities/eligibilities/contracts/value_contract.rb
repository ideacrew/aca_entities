# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # Validation schema for Value
      class ValueContract < Dry::Validation::Contract
        params do
          required(:title).filled(:string)
          optional(:description).maybe(:string)
          required(:key).filled(AcaEntities::Eligibilities::Types::GrantType)
        end
      end
    end
  end
end
