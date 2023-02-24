# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 InsurancePolicyContract
        class InsurancePolicyContract < Dry::Validation::Contract
          params do
            required(:InsuranceCoverages).array(AcaEntities::Fdsh::H36::Contracts::InsuranceCoverageContract.params)
          end
        end
      end
    end
  end
end