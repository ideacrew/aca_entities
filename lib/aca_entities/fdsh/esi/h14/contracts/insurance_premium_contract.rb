# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class InsurancePremiumContract < Dry::Validation::Contract
          params do
            required(:InsurancePremiumAmount).filled(:float)
          end
        end
      end
    end
  end
end