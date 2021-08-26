# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSAQuartersOfCoverageContract < Dry::Validation::Contract
          params do
            required(:LifeTimeQuarterQuantity).maybe(:integer)
            required(:QualifyingYearAndQuarter).maybe(AcaEntities::Fdsh::Ssa::H3::QualifyingYearAndQuarterContract.params)
          end
        end
      end
    end
  end
end