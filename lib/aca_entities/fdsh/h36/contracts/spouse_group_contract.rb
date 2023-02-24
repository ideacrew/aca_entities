# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 SpouseGroupContract
        class SpouseGroupContract < Dry::Validation::Contract
          params do
            required(:Spouse).filled(AcaEntities::Fdsh::H36::Contracts::SpouseContract.params)
          end
        end
      end
    end
  end
end