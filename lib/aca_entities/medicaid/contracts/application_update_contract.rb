# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Application update information contract
      class ApplicationUpdateContract < Dry::Validation::Contract
        params do
          optional(:activity_id).maybe(:hash)
          optional(:activity_date).maybe(:hash)
        end
      end
    end
  end
end