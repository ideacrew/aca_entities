# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 DependentGroupContract
        class DependentGroupContract < Dry::Validation::Contract
          params do
            required(:DependentPerson).filled(AcaEntities::Fdsh::H36::Contracts::DependentPersonContract.params)
          end
        end
      end
    end
  end
end