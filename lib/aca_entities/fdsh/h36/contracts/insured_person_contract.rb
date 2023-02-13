# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 InsuredPersonContract
        class InsuredPersonContract < Dry::Validation::Contract
          params do
            required(:OtherCompletePersonName).filled(AcaEntities::Fdsh::H36::Contracts::OtherCompletePersonNameContract.params)
            optional(:SSN).maybe(:string)
            optional(:BirthDt).maybe(:date)
          end
        end
      end
    end
  end
end