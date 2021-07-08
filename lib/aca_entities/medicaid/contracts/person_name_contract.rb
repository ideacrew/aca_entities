# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonName.
      class PersonNameContract < Dry::Validation::Contract

        params do
          required(:given).filled(:string)
          optional(:middle).maybe(:string)
          required(:sur).filled(:string)
          optional(:suffix).maybe(:string)
          optional(:full).maybe(:string)
        end
      end
    end
  end
end
