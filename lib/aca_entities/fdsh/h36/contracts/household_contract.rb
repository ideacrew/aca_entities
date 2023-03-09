# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 HouseholdContract
        class HouseholdContract < Dry::Validation::Contract
          params do
            required(:PrimaryGroup).filled(AcaEntities::Fdsh::H36::Contracts::PrimaryGroupContract.params)
            optional(:SpouseGroup).maybe(AcaEntities::Fdsh::H36::Contracts::SpouseGroupContract.params)
            optional(:DependentGroups).array(AcaEntities::Fdsh::H36::Contracts::DependentGroupContract.params)
            optional(:AssociatedPolicies).array(AcaEntities::Fdsh::H36::Contracts::AssociatedPolicyContract.params)
          end
        end
      end
    end
  end
end