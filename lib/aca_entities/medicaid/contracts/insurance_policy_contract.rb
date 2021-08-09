# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Insurance policy contract
      class InsurancePolicyContract < Dry::Validation::Contract
        params do
          optional(:member).maybe(:hash)
          optional(:policy_id).maybe(:hash)
          optional(:premium).maybe(:hash)
          optional(:source_code).maybe(:string)
          optional(:applied_effective_date_range).maybe(:hash)
        end
      end
    end
  end
end