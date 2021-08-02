# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Application submission information contract
      class ApplicationSubmissionContract < Dry::Validation::Contract
        params do
          optional(:activity_id).maybe(:hash)
          optional(:activity_date).maybe(:hash)
        end
      end
    end
  end
end