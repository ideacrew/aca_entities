# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for primary contact
      class PrimaryContactContract < Dry::Validation::Contract

        params do
          required(:person_name).filled(:hash)
          optional(:identifying_information).maybe(:hash)
          required(:addresses).filled(:array)
          required(:phones).filled(:array)
          required(:preferences).filled(:array)
        end
      end
    end
  end
end
