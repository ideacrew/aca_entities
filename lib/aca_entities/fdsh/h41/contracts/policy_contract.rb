# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 PolicyContract
        class PolicyContract < Dry::Validation::Contract
          params do
            required(:MarketPlacePolicyNum).filled(:string)
            required(:PolicyIssuerNm).filled(:string)
            required(:PolicyStartDt).filled(:date)
            required(:PolicyTerminationDt).filled(:date)
          end
        end
      end
    end
  end
end