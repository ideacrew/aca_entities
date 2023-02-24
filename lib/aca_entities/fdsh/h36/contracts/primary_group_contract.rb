# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 PrimaryGroupContract
        class PrimaryGroupContract < Dry::Validation::Contract
          params do
            required(:Primary).filled(AcaEntities::Fdsh::H36::Contracts::PrimaryContract.params)
          end
        end
      end
    end
  end
end