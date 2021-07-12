# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Street information contract
      class StreetContract < Dry::Validation::Contract
        params do
          optional(:street_full_text).maybe(:string)
        end
      end
    end
  end
end