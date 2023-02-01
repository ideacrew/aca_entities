# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 CoverageIndividualContract
        class CoveredIndividualContract < Dry::Validation::Contract
          params do
            required(:InsuredPerson).filled(AcaEntities::Fdsh::H41::Contracts::InsuredPersonContract.params)
            required(:CoverageStartDt).filled(:date)
            optional(:CoverageEndDt).maybe(:date)
          end
        end
      end
    end
  end
end