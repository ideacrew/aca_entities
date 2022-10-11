# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC InsurancePolicyContract
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