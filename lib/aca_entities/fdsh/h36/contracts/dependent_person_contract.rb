# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 DependentPersonContract
        class DependentPersonContract < Dry::Validation::Contract
          params do
            required(:CompletePersonName).filled(AcaEntities::Fdsh::H36::Contracts::CompletePersonNameContract.params)
            optional(:SSN).maybe(:string)
            optional(:BirthDt).maybe(:date)
          end
        end
      end
    end
  end
end