# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # AuthorizedRepresentativeReference information contract
      class AuthorizedRepresentativeReferenceContract < Dry::Validation::Contract
        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end