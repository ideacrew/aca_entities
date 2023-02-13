# frozen_string_literal: true

module AcaEntities
    module Fdsh
      module H36
        module Contracts
          # Contract for H36 InsuredPersonContract
          class IrsHouseholdGrpContract < Dry::Validation::Contract
            params do
              required(:IRSGroupIdentificationNum).filled(:string)
              required(:TaxHousehold).array(AcaEntities::Fdsh::H36::Contracts::TaxHouseholdCoverage.params)
              required(:InsurancePolicy).array(AcaEntities::Fdsh::H36::Contracts::InsuredPersonContract.params)
            end
          end
        end
      end
    end
  end