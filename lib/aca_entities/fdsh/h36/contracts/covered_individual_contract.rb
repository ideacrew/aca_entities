# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 InsuredPersonContract
        class CoveredIndividualContract < Dry::Validation::Contract
          params do
            required(:InsuredPerson).filled(AcaEntities::Fdsh::H36::Contracts::InsuredPersonContract.params)
            required(:CoverageStartDt).filled(:date)
            optional(:CoverageEndDt).maybe(:date)
          end
        end
      end
    end
  end
end