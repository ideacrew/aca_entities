# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # AssisterAssociation information contract
      class InsuranceApplicationAssisterAssociationnContract < Dry::Validation::Contract
        params do
          optional(:begin_date).filled(:hash)
          optional(:end_date).maybe(:hash)
          optional(:assister_reference).maybe(:hash)
        end
      end
    end
  end
end