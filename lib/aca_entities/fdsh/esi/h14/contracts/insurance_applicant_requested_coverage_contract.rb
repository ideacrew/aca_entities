# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class InsuranceApplicantRequestedCoverageContract < Dry::Validation::Contract
          params do
            required(:StartDate).filled(:date)
            required(:EndDate).filled(:date)
          end
        end
      end
    end
  end
end