# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 UsAddressGroupContract
        class PersonAddressGroupContract < Dry::Validation::Contract
          params do
            required(:UsAddressGroup).filled(AcaEntities::Fdsh::H36::Contracts::UsAddressGroupContract.params)
          end
        end
      end
    end
  end
end