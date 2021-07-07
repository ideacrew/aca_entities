# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # SignatureDate information contract
      class SignatureDateContract < Dry::Validation::Contract
        params do
          required(:date).filled(:date)
        end
      end
    end
  end
end