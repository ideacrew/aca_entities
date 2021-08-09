# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class QualifyingYearAndQuarterContract < Dry::Validation::Contract
          params do
            required(:QualifyingYear).maybe(:string)
            required(:QualifyingQuarter).maybe(:integer)
          end
        end
      end
    end
  end
end