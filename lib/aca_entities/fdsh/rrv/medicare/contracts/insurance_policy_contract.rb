# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV InsurancePolicyContract
        class InsurancePolicyContract < Dry::Validation::Contract
          params do
            required(:InsurancePolicyEffectiveDate).filled(:date)
            required(:InsurancePolicyExpirationDate).filled(:date)
          end
        end
      end
    end
  end
end