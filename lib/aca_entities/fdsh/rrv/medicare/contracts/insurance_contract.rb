# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV InsurancePolicyContract
        class InsuranceContract < Dry::Validation::Contract
          params do
            optional(:InsuranceEffectiveDate).filled(:date)
            optional(:InsuranceEndDate).filled(:date)
          end
        end
      end
    end
  end
end