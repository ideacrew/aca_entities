# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class InsurancePremiumContract < Dry::Validation::Contract
            params do
              required(:InsurancePremiumAmount).filled(:decimal)
            end
          end
        end
      end
    end
  end
end