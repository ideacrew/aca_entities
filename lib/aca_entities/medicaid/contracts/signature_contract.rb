# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Signature information contract
      class SignatureContract < Dry::Validation::Contract
        params do
          required(:date_time).filled(:hash)
        end
      end
    end
  end
end