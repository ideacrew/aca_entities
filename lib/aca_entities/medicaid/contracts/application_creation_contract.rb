# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Applicayion creation information contract
      class ApplicationCreationContract < Dry::Validation::Contract
        params do
          optional(:creation_id).maybe(:hash)
          optional(:creation_date).maybe(:hash)
        end
      end
    end
  end
end