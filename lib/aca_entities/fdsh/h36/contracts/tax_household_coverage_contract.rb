# frozen_string_literal: true

module AcaEntities
    module Fdsh
      module H36
        module Contracts
          # Contract for H36 InsuredPersonContract
          class TaxHouseholdCoverageContract < Dry::Validation::Contract
            params do
              required(:ApplicableCoverageMonthNum).filled(:string)
              required(:OtherRelevantAdult).array(:hash) do
                required(:CompletePersonName).filled(AcaEntities::Fdsh::H36::Contracts::OtherCompletePersonNameContract.params)
                optional(:SSN).maybe(:string)
                optional(:BirthDt).maybe(:date)
                required(:CompletePersonName).filled(AcaEntities::Fdsh::H36::Contracts::OtherCompletePersonNameContract.params)
                required(:PersonAddressGrp).array(:hash) do
                    required(:USAddressGrp).filled(AcaEntities::Fdsh::H36::Contracts::UsAddressGroupContract.params)
                end
              end
            end
          end
        end
      end
    end
  end