# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # HouseholdMemberReference information contract
      class HouseholdMemberReferenceContract < Dry::Validation::Contract
        params do
          required(:ref).filled(:string)
        end
      end
    end
  end
end