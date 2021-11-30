# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Assister contract
      class AssisterContract < Dry::Validation::Contract
        params do
          optional(:role_played_by_person).maybe(:hash)
        end
      end
    end
  end
end